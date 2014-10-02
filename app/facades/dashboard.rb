class Dashboard

  def initialize(user)
    @user = user
  end

  attr_reader :user

  def my_rants
    user.rants
  end

  def latest_rants
    Rant.where('user_id <> ?', user.id)
  end
end