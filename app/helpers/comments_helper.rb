module CommentsHelper

  def authenticate_user!
    if user_signed_in?
      super
    else
      flash[:danger] = t "devise.failure.unauthenticated"
      redirect_to new_user_session_path
    end
  end
end
