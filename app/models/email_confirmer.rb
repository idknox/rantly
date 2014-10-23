class EmailConfirmer < ActiveRecord::Base

  def self.set_confirmation_token(user)
    email_confirmer = new(user_id: user.id, confirmation_token: SecureRandom.uuid)
    email_confirmer.save!
    email_confirmer.confirmation_token
  end
end
