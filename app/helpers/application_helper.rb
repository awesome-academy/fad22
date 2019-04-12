module ApplicationHelper
  def full_title page_title
    base_title = t ".fastfood"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def current_user? user
    current_user == user
  end

  def logged_in_user
    return if user_signed_in?
    flash[:danger] = "Please sign in first"
    redirect_to new_user_session_path
  end
end
