class RantsController < ApplicationController
  def create
    rant = Rant.new(rant_params)
    rant.user_id = current_user.id

    if rant.save
      UserMailer.new_rant(current_user).deliver
      rant.publish_rant_to_keen
      render nothing: true
    else
      errors = rant.errors.messages
      render json: {errors: errors}
    end
  end

  def destroy
    rant = Rant.find(params[:id])
    rant.destroy
    flash[:notice] = "Rant deleted"
    redirect_to :back
  end

  def show
    rant = Rant.find(params[:id])
    @rant_dashboard = RantDashboard.new(rant)
    puts "*" * 80
    puts @rant_dashboard.rant.comments.length
    puts "*" * 80
    redirect_to root_path if rant.spam
  end

  def spam
    Rant.find(params[:rant_id]).update!(spam: true)
    redirect_to root_path
  end

  def unspam
    Rant.find(params[:rant_id]).update!(spam: false)
    redirect_to :back
  end

  private

  def rant_params
    params.require(:rant).permit(:subject, :body)
  end
end
