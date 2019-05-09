class UsersController < ApplicationController
  before_action :load_user, except: %i(new index create)
  before_action :correct_user, only: %i(edit update)
  before_action :logged_in_user, only: %i(index edit update)
  before_action :authenticate_user!

  def new
    @user = User.new
  end

  def show
    @orders = @user.orders.where(status: :delivering)
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:sucess] = t ".profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def index
    @users = User.order_desc.paginate page: params[:page],
      per_page: Settings.per_page.users_index
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "users.load_user.not_found"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :address, :phone_number,
      :password, :password_confirmation
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
