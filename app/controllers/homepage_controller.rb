class HomepageController < ApplicationController
  skip_before_action :ensure_current_user, only: :show

  def show
    track_visits
  end

  private

  def track_visits
    update_visited_count
    cookies.permanent[:visited] ||= 0
  end

  def update_visited_count
    cookies.permanent[:visited] = cookies.permanent[:visited].to_i + 1 if cookies[:visited]
  end

end
