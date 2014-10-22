class UserMailer < ActionMailer::Base
  default from: "admin@rantly.com"

  def registration(recipient)
    mail to: recipient.email, subject: 'Rantly Signup Confirmation'
  end

  def confirmation(recipient)
    confirmation_token = set_confirmation_token(recipient)
    @confirmation_url = email_confirmation_path(confirmation_token)
    mail to: recipient.email, subject: 'Please Confirm Your Rantly Membership'
  end

  private

  def set_confirmation_token(user)
    email_confirmer = EmailConfirmer.new(user_id: user.id, confirmation_token: SecureRandom.uuid)
    email_confirmer.save!
    email_confirmer.confirmation_token
  end
end
