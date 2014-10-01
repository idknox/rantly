class Dashboard

  def initialize(user, rant=nil)
    @user = user
    @rant = rant
  end

  attr_reader :user
  attr_accessor :rant

  def new_rant
    @rant ||= Rant.new
  end

  def my_rants
    user.rants
  end

  def latest_rants
    Rant.where('user_id <> ?', user.id)
  end
end