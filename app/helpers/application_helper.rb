module ApplicationHelper

  def user_has_visited_and_not_registered?
    user_has_visited? && !user_has_registered?
  end

  def on_user_edit_page?
    current_page? edit_user_path(current_user)
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

  def on_admin_rants_page?
    current_page? admin_rants_path
  end

  def on_admin_spam_page?
    current_page? admin_spam_path
  end

  def on_admin_users_page?
    current_page? admin_users_path
  end

  def on_admin_dashboard_page?
    current_page? admin_dashboard_path
  end

  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text).html_safe
  end

  def remaining_table_row_count(collection)
    (1..(15-collection.length))
  end

  private
  def user_has_visited?
    cookies[:visited] == 1
  end

  def user_has_registered?
    cookies[:registered]
  end
end
