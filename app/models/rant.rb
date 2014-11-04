class Rant < ActiveRecord::Base
  belongs_to :user
  has_many :favorites
  has_many :comments, as: :commentable

  validate :greater_than_140_characters

  def greater_than_140_characters
    if body.length <= 140
      errors.add(:base, "Rant must be more than 140 characters")
    end
  end

  def body_truncated_if_needed
    too_long_for_full_display? ? truncated_body : body
  end

  def get_favorite(user)
    favorites.find_by(user_id: user.id)
  end

  def favorite_count
    favorites.length
  end

  def self.search_all(search)
    joins(:user).where(
      'users.username = ? OR users.first_name = ?' +
        'OR users.last_name = ? OR rants.body LIKE ?' +
        'OR rants.subject LIKE ?',
      search,
      search,
      search,
      '%' + search + '%',
      '%' + search + '%'
    ).no_spam
  end

  def self.spam_only
    where(spam: true)
  end

  def self.no_spam
    where(spam: false)
  end

  def publish_rant_to_keen
    Keen.publish(:rants, {user: user.username})
  end

  private


  def too_long_for_full_display?
    body.split(' ').length > 300
  end

  def truncated_body
    body.split(' ')[0..300].join(' ') + '...'
  end

end