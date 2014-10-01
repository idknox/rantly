class FavoritesController < ApplicationController
  def create
    Favorite.create!(user_id: current_user.id, rant_id: params[:rant_id])
    redirect_to :back
  end

  def destroy
    Favorite.destroy(params[:id])
    redirect_to :back
  end

  def index
    @favorites = Favorite.where(user_id: current_user.id)
  end
end