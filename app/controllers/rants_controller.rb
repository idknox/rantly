class RantsController < ApplicationController
  def create
    rant = Rant.new(rant_params)
    rant.user_id = session[:user_id]
    unless rant.save

    end
    redirect_to :back
  end

  def destroy
    rant = Rant.find(params[:id])
    rant.destroy
    flash[:notice] = "Rant deleted"
    redirect_to :back
  end

  def show
    @rant = Rant.find(params[:id])
  end

  private

  def rant_params
    params.require(:rant).permit(:subject, :body)
  end
end
