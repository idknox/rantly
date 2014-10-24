class AdminController < ApplicationController
  before_action :ensure_admin

  def ensure_admin
    redirect_to homepage_path unless you_are_admin? || admin_logged_in?
  end

  def dashboard
  end

  def rants
    @rants = Filter.new(params).filtered_if_needed(Rant.no_spam).order(:created_at)
  end

  def spam
    @rants = Filter.new(params).filtered_if_needed(Rant.spam_only).order(:created_at)
  end

  def users
    @users = User.sorted_by_rant_count
    @users.reverse! if params[:sort_desc]
  end

  def disable
    user = User.find(params[:user_id])
    user.update_attribute(:disabled, true)
    redirect_to :back
  end

  def enable
    user = User.find(params[:user_id])
    user.update_attribute(:disabled, false)
    redirect_to :back
  end

  def logins_chart
    render json: User.keen_login_data
  end

  def impersonate
    session[:admin_id] = current_user.id
    session[:user_id] = params[:user_id]
    redirect_to root_path
  end

  def unimpersonate
    session[:user_id] = session[:admin_id]
    session.delete(:admin_id)
    redirect_to root_path
  end
end