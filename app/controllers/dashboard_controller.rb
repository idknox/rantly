class DashboardController < ApplicationController
  def show
    @dashboard = Dashboard.new(User.find(session[:user_id]))
  end
end