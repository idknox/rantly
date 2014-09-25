class UsersController < ApplicationController
  skip_before_action :ensure_current_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
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
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Profile Updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name, :bio, :rant_frequency)
  end
end
