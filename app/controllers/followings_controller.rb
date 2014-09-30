class FollowingsController < ApplicationController
  def index
    @dashboard = Dashboard.new(current_user)
  end

  def create
    User.find(current_user.id).follow!(params[:followee_id])
    redirect_to :back
  end

  def destroy
    User.find(current_user.id).unfollow!(params[:followee_id])
    redirect_to :back
  end
end