class User < ActiveRecord::Base
  has_many :rants, dependent: :destroy
  has_many :favorites
  has_many :followings, foreign_key: "follower_id", dependent: :destroy
  has_many :followees, through: :followings
  has_many :images
  has_many :comments


  has_secure_password
  validates :username, :password, :email, :first_name, :last_name, :bio, :rant_frequency, presence: true
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

  def publish_registration_to_keen
    Keen.publish(:users, {username: username})

  end

  def publish_login_to_keen
    Keen.publish(:logins, {username: username, time: Time.now.strftime("%I %P")})
  end

  def send_confirmation_email
    confirmation_token = set_confirmation_token
    UserMailer.confirmation(self, email_confirmation_url(confirmation_token)).deliver
  end

  def self.sorted_by_rant_count
    all.sort_by { |user| user.number_of_rants }.reverse
  end

  def self.keen_login_data
    url = "https://api.keen.io/3.0/projects/54497c82072719342addb0cd/queries/count?api_key=e9edaffeaa76fcc6aaeda68fb266aaa7063dfc2f62b85f0c886955ce4417179b39fac604203ca34cf8106457dc643f1f7d9cb410b967b797533cf5fe504b0a032ac89f2ec95498a7c6673811f31d85b49a4edfcf60ae559ddbed22a393926dc5845115c42d321ba2972a903ace45e09d&event_collection=logins&timezone=-21600&group_by=time"
    file = open(url) { |f| f.read }
    logins = JSON.parse(file)["results"]
    logins.map {|login|}
  end

  private

  def set_confirmation_token
    email_confirmer = EmailConfirmer.new(user_id: id, confirmation_token: SecureRandom.uuid)
    email_confirmer.save!
    email_confirmer.confirmation_token
  end

end