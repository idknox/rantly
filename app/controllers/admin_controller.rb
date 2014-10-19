class AdminController < ApplicationController
  before_action :ensure_admin

  def ensure_admin
    redirect_to homepage_path unless you_are_admin?
  end

  def rants
    @rants = params[:spam] ? Rant.where(spam: true) : Rant.all
  end
end