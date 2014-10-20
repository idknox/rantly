class AdminController < ApplicationController
  before_action :ensure_admin

  def ensure_admin
    redirect_to homepage_path unless you_are_admin?
  end

  def rants
    puts "*" * 80
    puts params
    puts "*" * 80

    @rants = determine_if_filtered.order(:created_at)
  end

  private

  def determine_if_filtered
    filters_exist? ? filtered_rants(determine_rants_or_spam) : determine_rants_or_spam
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

  def determine_rants_or_spam
    params[:spam] ? Rant.spam_only : Rant.no_spam
  end
end