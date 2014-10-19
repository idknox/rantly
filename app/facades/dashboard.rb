class Dashboard

  def initialize(user)
    @user = user
  end

  attr_reader :user

  def my_rants
    user.rants.where('spam <> true')
  end

  def latest_rants
    Rant.where('user_id <> ? AND spam <> true', user.id)
  end

  def mentioned_rants(user)
    Rant.where('body LIKE ? AND spam <> true', '%@' + user.username + '%')
  end
end