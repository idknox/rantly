class RantsController < ApplicationController
  def create
    rant = Rant.new(rant_params)
    rant.user_id = session[:user_id]

    redirect_to root_path
  end

  private

  def rant_params
    params.require(:rant).permit(:subject, :body)
  end
end
