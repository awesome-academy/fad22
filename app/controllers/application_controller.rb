class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order
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
