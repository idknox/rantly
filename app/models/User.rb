class User < ActiveRecord::Base
  has_many :rants
  has_many :favorites
  has_many :followings, foreign_key: "follower_id", dependent: :destroy
  has_many :followees, through: :followings

  has_secure_password
  validates :username, :password, :first_name, :last_name, :bio, :rant_frequency, presence: true
  validates :username, uniqueness: true
  validates :password, length: {minimum: 8}

  def following?(followee_id)
    followings.find_by(followee_id: followee_id)
  end

  def follow!(followee_id)
    followings.create!(followee_id: followee_id)
  end

  def unfollow!(followee_id)
    followings.find_by(followee_id: followee_id).destroy
  end

  def rants_sorted_by_favorites
    rants.sort_by { |rant| rant.favorite_count }.reverse
  end
end