class UsersController < ApplicationController
  before_action :load_user, only: :show

  def new
    @user = User.new
  end

  def show; end

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
end
