module ApplicationHelper

  def user_has_visited_and_not_registered?
    user_has_visited? && !user_has_registered?
  end

  def on_dashboard_page?
    current_page? root_path
  end

  def on_followings_page?
    current_page? user_followings_path(current_user)
  end

  def on_favorites_page?
    current_page? favorites_path(current_user)
  end

  def on_search_page?
    (current_page? new_search_path) || (current_page? search_path)
  end

  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text).html_safe
  end

  private
  def user_has_visited?
    cookies[:visited] == 1
  end

  def user_has_registered?
    cookies[:registered]
  end
end
