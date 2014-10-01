class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :ensure_current_user

  def ensure_current_user
    redirect_to homepage_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user_dashboard
    Dashboard.new(current_user)
  end

  helper_method :current_user
  helper_method :current_user_dashboard
end
