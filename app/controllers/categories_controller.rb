class CategoriesController < ApplicationController
  before_action :load_category, only: :show
  authorize_resource
  def show; end

  def index
    @categories =
      Category.find_categories(0).order_follow_created_at
              .paginate page: params[:page],
              per_page: Settings.per_page.users_index
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "categories.load_category.category_not_found"
    redirect_to root_path
  end
end
