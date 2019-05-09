class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    @products = if filtering_params.blank?
                  Product.find_product(0)
                         .order_by_name.paginate page: params[:page],
                         per_page: 18
                else
                  Product.where(filtering_params)
                         .order_by_name.paginate page: params[:page],
                         per_page: 18
                end
    @order_detail = current_order.order_details.new if user_signed_in?
  end

  def show
    @order_detail = @order_detail = current_order.order_details.new
    @comment = Comment.new
    @comments = @product.comments.order(created_at: :DESC)
                        .paginate page: params[:page], per_page: 10
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "products.load_product.product_not_found"
    redirect_to root_path
  end

  def filtering_params
    filter = params.permit :category, :status
    if params[:price].present?
      price = params[:price].split("-")
      filter[:price] = price[0].to_i..price[1].to_i
    end
    filter.reject{|_k, v| v.blank?}
  end
end
