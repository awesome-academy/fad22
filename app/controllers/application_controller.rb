class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json{head :forbidden, content_type: "text/html"}
      format.html{redirect_to main_app.root_url, notice: exception.message}
      format.js{head :forbidden, content_type: "text/html"}
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def current_order
    return unless user_signed_in?
    @order = current_user.orders.find_by status: "waiting"
    return @order if @order
    @order = Order.new
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      flash[:danger] = t ".please_login"
      redirect_to new_user_session_path
    end
  end
end
