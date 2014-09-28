class RantsController < ApplicationController
  def create
    rant = Rant.new(rant_params)
    rant.user_id = session[:user_id]
    rant.save
    redirect_to root_path
  end

  def destroy
    rant = Rant.find(params[:id])
    rant.destroy
    flash[:notice] = "Rant deleted"
    redirect_to :back
  end

  private

  def rant_params
    params.require(:rant).permit(:subject, :body)
  end
end
