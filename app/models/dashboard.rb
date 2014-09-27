class Dashboard

  def initialize(user)
    @user = user
  end

  attr_reader :user

  def new_rant
    @rant ||= Rant.new
  end

  def my_rants
    @rants ||= user.rants
  end
end