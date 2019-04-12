class Admin::ProductsController < Admin::BaseController
  before_action :load_product, only: %i(edit update destroy)
  include OrdersHelper

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:sucess] = t ".product_created"
      redirect_to products_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update_attributes product_params
      if @product.normal?
        flash[:sucess] = t ".product_updated"
        redirect_to @product
      elsif @product.deleted?
        @orders = find_order_by_product_id(@product.id)
        ProductMailer.product_deleted(@product, @orders).deliver_now
        flash[:sucess] = t ".product_deleted"
        redirect_to products_path
      end
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t ".product_deleted"
    else
      flash[:danger] = t ".cant_delete"
    end
    redirect_to products_path
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "admin.products.load_product.product_not_found"
    redirect_to root_path
  end

  def product_params
    params.require(:product).permit :name, :price, :description, :image_link,
      :quantity, :category_id, :status
  end
end
