class FollowingsController < ApplicationController
  def index
    @dashboard = Dashboard.new(current_user)
  end

  def create
    following = Following.new(
      follower_id: current_user.id,
      followee_id: params[:user_id]
    )
    following.save
    redirect_to root_path
  end

end