class Dashboard

  def initialize(user)
    @user = user
  end

  attr_reader :user

  def new_rant
    @rant ||= Rant.new
  end

  def my_rants
    user.rants
  end

  def latest_rants
    Rant.where('user_id <> ?', user.id)
  end

  def current_page
    request.original_url.split("/").last
  end
end