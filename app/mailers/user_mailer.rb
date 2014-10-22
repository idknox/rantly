class UserMailer < ActionMailer::Base
  default from: "admin@rantly.com"

  def registration(recipient)
    mail to: recipient.email, subject: 'Rantly Signup Confirmation'
  end

end
