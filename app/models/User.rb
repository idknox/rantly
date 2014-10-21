class User < ActiveRecord::Base
  has_many :rants, dependent: :destroy
  has_many :favorites
  has_many :followings, foreign_key: "follower_id", dependent: :destroy
  has_many :followees, through: :followings
  has_many :images
  has_many :comments


  has_secure_password
  validates :username, :password, :first_name, :last_name, :bio, :rant_frequency, presence: true
  validates :username, uniqueness: true, unless: :force_submit
  validates :password, length: {minimum: 8}

  attr_accessor :force_submit

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

  def number_of_rants
    rants.length
  end

  def disabled?
    disabled
  end

  def create_image(image)
    Image.create!(
      user_id: id,
      filename: image.first.original_filename,
      content_type: image.first.content_type,
      data: image.first.read
    ) if image
  end

  def self.sorted_by_rant_count
    all.sort_by {|user| user.number_of_rants }.reverse
  end
end