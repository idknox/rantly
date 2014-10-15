class AdminController < ApplicationController
  before_action :ensure_admin

  def ensure_admin
    redirect_to homepage_path unless you_are_admin?
  end

  def rants

  end
end