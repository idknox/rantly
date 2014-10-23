class UserMailer < ActionMailer::Base
  default from: "admin@rantly.com"

  def registration(recipient)
    mail to: recipient.email, subject: 'Thanks for Joining Rantly!'
  end

  def confirmation(recipient)
    confirmation_token = EmailConfirmer.set_confirmation_token(recipient)
    @confirmation_url = email_confirmation_url(confirmation_token)
    @user = recipient
    mail to: recipient.email, subject: 'Please Confirm Your Rantly Membership'
  end

  def new_rant(ranter)
    Following.where(followee_id: ranter.id).each do |following|
      user = User.find(following.follower_id)
      @ranter = ranter
      mail to: user.email, subject: "#{ranter.first_name} Has Posted a New Rant!"
    end
  end
end
