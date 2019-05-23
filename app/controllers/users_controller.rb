class UsersController < ApplicationController
  before_action :load_user, except: %i(new index create)
  before_action :correct_user, only: %i(edit update)
  authorize_resource

  def show
    @orders = @user.orders.where(status: :delivering)
  end

  def index
    @search = User.ransack params[:q]
    @users = @search.result.order_desc.paginate page: params[:page],
      per_page: Settings.per_page.users_index
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "users.load_user.not_found"
    redirect_to root_path
  end

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t "users.logged_in_user.please_login"
    redirect_to login_path
  end

  def correct_user
    redirect_to(root_path) unless current_user?(@user)
  end
end
