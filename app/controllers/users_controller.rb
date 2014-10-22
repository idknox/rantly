class UsersController < ApplicationController
  skip_before_action :ensure_current_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.create_image(params[:user][:image])
      set_registered_cookie
      UserMailer.registration(@user).deliver
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
    @user = User.find(params[:id])
    @user.force_submit = true
    if @user.update_attributes(user_params_without_image)
      @user.create_image(params[:user][:image])
      flash[:notice] = "Profile Updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :first_name, :last_name, :bio, :rant_frequency, :image, :admin, :disabled)
  end

  def user_params_without_image
    params.require(:user).permit(:username, :password, :email, :first_name, :last_name, :bio, :rant_frequency, :admin, :disabled)
  end

  def set_registered_cookie
    cookies.permanent[:registered] = true
  end

end
