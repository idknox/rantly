class CommentsController < ApplicationController
  def create
    @comment = Comment.new(
      user_id: current_user.id,
      rant_id: params[:rant_id],
      body: params[:comment][:body]
    )
    if @comment.save
      flash[:notice] = 'Comment added'
      redirect_to :back
    else
      @rant_dashboard = RantDashboard.new(Rant.find(params[:id]))
      render 'rants/show'
    end
  end
end