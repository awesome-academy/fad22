class OrdersController < ApplicationController
  def edit
    @order = Order.find_by id: current_order.id
  end

  def update
    @order = Order.find_by id: current_order.id
    @order.update_attributes order_params
    session.delete :order_id
    redirect_to products_path
  end

  private

  def order_params
    op = params.require(:order).permit :delivery_address, :status
    op.reject{|_k, v| v.blank?}
  end
end
