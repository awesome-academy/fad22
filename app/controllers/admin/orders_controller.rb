class Admin::OrdersController < Admin::BaseController
  before_action :load_order, only: %i(update destroy)

  def index
    @orders_delivering = Order.find_order_by_status("delivering")
    @orders_delivered = Order.find_order_by_status("delivered")
    @orders_cancel = Order.find_order_by_status("cancel")
  end

  def update
    @order.update_attributes order_params
    redirect_to admin_orders_path
  end

  def destroy
    if @order.destroy
      flash[:success] = "Order deleted!"
    else
      flash[:danger] = "Cant delete this order"
    end
    redirect_to admin_orders_path
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = "Order not found"
    redirect_to admin_orders_path
  end

  def order_params
    params.require(:order).permit :status
  end
end
