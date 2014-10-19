class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :ensure_current_user

  def ensure_current_user
    redirect_to homepage_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def new_rant
    @rant ||= Rant.new
  end

  def you_are_admin?
    current_user && current_user.admin
  end

  helper_method :current_user
  helper_method :new_rant
  helper_method :you_are_admin?
end
