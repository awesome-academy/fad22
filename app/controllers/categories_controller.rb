class CategoriesController < ApplicationController
  include UsersHelper
  before_action :load_category, only: :show

  def show; end

  def index
    @categories = Category.desc_by_name.paginate page: params[:page],
      per_page: Settings.per_page.users_index
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "categories.load_category.category_not_found"
    redirect_to root_path
  end
end
