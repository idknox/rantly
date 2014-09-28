class Rant < ActiveRecord::Base
  belongs_to :user

  validate :greater_than_140_characters

  def greater_than_140_characters
    if body.length <= 140
      errors.add(:base, "Rant m ust be more than 140 characters")
    end
  end
end