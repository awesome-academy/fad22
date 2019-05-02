class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: :destroy
  def destroy
    if @user.destroy
      flash[:sucess] = t ".user_deleted"
    else
      flash[:danger] = t "cant_delete"
    end
    redirect_to users_path
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "users.load_user.not_found"
    redirect_to root_path
  end
end
