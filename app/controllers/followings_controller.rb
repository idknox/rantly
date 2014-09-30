class FollowingsController < ApplicationController
  def index
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