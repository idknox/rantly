module ApplicationHelper

  def user_has_visited_and_not_registered?
    user_has_visited? && !user_has_registered?
  end

  private
  def user_has_visited?
    cookies[:visited] == 1
  end

  def user_has_registered?
    cookies[:registered]
  end
end
