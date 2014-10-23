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

  private


end
