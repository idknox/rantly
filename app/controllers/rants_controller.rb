class RantsController < ApplicationController
  def create
    @rant = Rant.new(rant_params)
    @rant.user_id = current_user.id
    if @rant.save
      flash[:notice] = "Rant created"
      redirect_to :back
    else
      @dashboard = Dashboard.new(current_user)
      render 'dashboard/show'
    end
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
