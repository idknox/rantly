class Rant < ActiveRecord::Base
  belongs_to :user

  validate :greater_than_140_characters

  def greater_than_140_characters
    if body.length <= 140
      errors.add(:base, "Rant must be more than 140 characters")
    end
  end

  def truncated_body
    last_word_index = too_long_for_full_display? ? end_of_last_word : end_of_rant
    body[0..last_word_index] + "..."
  end

  private

  def too_long_for_full_display?
    body.length > 500
  end

  def end_of_last_word
    body[0..500].rindex(" ") - 1
  end

  def end_of_rant
    body.length-1
  end

end