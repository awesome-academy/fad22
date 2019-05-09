class OrderDetailsController < ApplicationController
  before_action :load_current_order, only: %i(create update destroy)
  before_action :load_order_detail, only: %i(update destroy)
  before_action :load_order_detail_by_product_id, only: :create
  before_action :check_params_quantity, only: %i(create update)

  def create
    if @order_detail.nil?
      @order_detail = @order.order_details.new order_detail_params
    else
      quantity = @order_detail.quantity
      @order_detail.update_attribute(:quantity,
        quantity + params[:order_detail][:quantity].to_i)
    end
    @order.user_id = current_user.id
    @order.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @order_detail.update_attributes order_detail_params
    @order_details = @order.order_details
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @order_detail.destroy
    @order_details = @order.order_details
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def load_order_detail_by_product_id
    @order_detail = @order.order_details.find_by(product_id:
      params[:order_detail][:product_id])
  end

  def load_current_order
    @order = current_order
  end

  def load_order_detail
    @order_detail = @order.order_details.find_by id: params[:id]
  end

  def order_detail_params
    params.require(:order_detail).permit :quantity, :product_id
  end

  def check_params_quantity
    @product = Product.find_by id: params[:order_detail][:product_id]
    if @product
      return if params[:order_detail][:quantity].to_i <= @product.quantity
      flash[:danger] = t "order_details.check_params_quantity.greater_quantity"
      redirect_to products_path
    else
      flash[:danger] = t "order_details.check_params_quantity.product_not_found"
    end
  end
end
