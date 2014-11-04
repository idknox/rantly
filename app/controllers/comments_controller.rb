class CommentsController < ApplicationController
  def create
    @comment = Comment.create!(
      commentable_id: params[:commentable_id],
      commentable_type: params[:type],
      author_id: current_user.id,
      body: params[:comment][:body]
    )
      flash[:notice] = 'Comment added'
      redirect_to :back
  end
end