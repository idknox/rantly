class UsersController < ApplicationController
  skip_before_action :ensure_current_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      Image.create!(
        user_id: @user.id,
        filename: params[:user][:image].first.original_filename,
        content_type: params[:user][:image].first.content_type,
        data: params[:user][:image].first.read
      ) if params[:user][:image]

      cookies.permanent[:registered] = true
      flash[:notice] = "Thank you for registering!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      Image.create!(
        user_id: user.id,
        filename: params[:user][:image].first.original_filename,
        content_type: params[:user][:image].first.content_type,
        data: params[:user][:image].first.read
      )
      flash[:notice] = "Profile Updated"
      redirect_to root_path
    else
      redirect_to :back
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name, :bio, :rant_frequency)
  end
end
