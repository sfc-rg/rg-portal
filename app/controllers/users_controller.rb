class UsersController < ApplicationController
  before_action :require_active_current_user
  before_action :require_admin
  before_action :set_user, only: :update

  def index
    @users = User.all
  end

  def update
    if @user.update(user_params)
      flash[:success] = '更新しました'
    else
      flash[:error] = '更新に失敗しました'
    end

    redirect_to action: :index
  end

  private

  def require_admin
    redirect_to root_path unless @current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:role)
  end
end
