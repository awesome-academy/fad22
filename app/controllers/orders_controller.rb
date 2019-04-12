class OrdersController < ApplicationController
  def edit
    @order = Order.find_by id: current_order.id
  end

  def update
    @order = Order.find_by id: params[:id]
    @order.update_attributes order_params
    if @order.delivering?
      @order.reduce_quantity_product
    elsif @order.cancel?
      @order.restore_quantity_product
    end
    redirect_to current_user
  end

  private

  def order_params
    op = params.require(:order).permit :delivery_address, :status
    op.reject{|_k, v| v.blank?}
  end
end
