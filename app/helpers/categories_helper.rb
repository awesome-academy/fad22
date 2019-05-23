module CategoriesHelper

  def list_categories
    @categories = Category.all
  end
end
