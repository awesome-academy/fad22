class CartsController < ApplicationController
  def show
    @order_details = current_order.order_details
  end

  def clear
    current_order.order_details.each(&:destroy)
    redirect_to carts_show_path
  end
end
