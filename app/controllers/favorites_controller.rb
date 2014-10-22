class FavoritesController < ApplicationController
  def create
    Favorite.create!(user_id: current_user.id, rant_id: params[:rant_id])

    redirect_to :back
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, rant_id: params[:rant_id]).destroy
    redirect_to :back
  end

  def index
  end
end