class AdminController < ApplicationController
  before_action :ensure_admin

  def ensure_admin
    redirect_to homepage_path unless you_are_admin?
  end

  def rants
    @rants = filtered_if_needed(Rant.no_spam).order(:created_at)
  end

  def spam
    @rants = filtered_if_needed(Rant.spam_only).order(:created_at)
  end

  private

  def filtered_if_needed(rants)
    filters_exist? ? filtered_rants(rants) : rants
  end

  def filters_exist?
    params[:starts_on] && params[:ends_on]
  end

  def filtered_rants(rants)
   one_blank_filter? ? partial_filtered(rants) : rants.where('created_at > ? AND created_at < ?', params[:starts_on], params[:ends_on])
  end

  def one_blank_filter?
    params[:ends_on] == '  /   /    ' || params[:starts_on] == '  /   /    '
  end

  def partial_filtered(rants)
    filtered_by_start_only = params[:ends_on] == '  /   /    '  ? rants.where('created_at > ?', params[:starts_on]) : rants
    params[:starts_on] == '  /   /    ' ? rants.where('created_at < ?', params[:ends_on]) : filtered_by_start_only
  end
end