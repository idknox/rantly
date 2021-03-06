class SessionsController < ApplicationController
  skip_before_action :ensure_current_user

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password]) && !@user.disabled && @user.confirmed
      session[:user_id] = @user.id
      @user.publish_login_to_keen unless you_are_admin?
      redirect_to root_path unless you_are_admin?
      redirect_to admin_dashboard_path if you_are_admin?
    elsif @user && @user.authenticate(params[:user][:password]) && !@user.confirmed
      @user = User.new(username: params[:user][:username])
      @user.errors[:base] << "Email is not confirmed"
      render :new
    elsif @user && @user.authenticate(params[:user][:password]) && @user.disabled
      @user = User.new(username: params[:user][:username])
      @user.errors[:base] << "Your account is disabled"
      render :new
    else
      @user = User.new(username: params[:user][:username])
      @user.errors[:base] << "Login failed"
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to homepage_path
  end
end