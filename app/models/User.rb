class User < ActiveRecord::Base
  has_many :rants
  has_many :followings, foreign_key: "follower_id", dependent: :destroy
  has_many :followees, through: :followings
  # has_many :followers, through: :followings

    has_secure_password
    validates :username, :password, :first_name, :last_name, :bio, :rant_frequency, presence: true
end