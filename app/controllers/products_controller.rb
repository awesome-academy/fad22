class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    @products = Product.desc_by_name.paginate page: params[:page],
      per_page: Settings.per_page.product_index
    @order_detail = current_order.order_details.new
  end

  def show; end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "products.load_product.product_not_found"
    redirect_to root_path
  end
end
