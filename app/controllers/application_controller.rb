class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :current_order
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def current_order
    return unless logged_in?
    @order = current_user.orders.find_by status: "waiting"
    return @order if @order
    @order = Order.new
  end
end
