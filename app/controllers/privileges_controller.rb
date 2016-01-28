class PrivilegesController < ApplicationController
  before_action :require_active_current_user

  def index
    @privilege_groups = Privilege.all.group_by(&:stringify)
  end

  def new
    @privilege = Privilege.new
  end

  def create
    @privilege = Privilege.new(privilege_params)
    if @current_user.has_privilege?(@privilege.model, @privilege.action)
      if @privilege.save
        message = "#{@privilege.user.nickname}に#{@privilege.stringify}の権限を共有しました"
        flash.now[:success] = message
      end
    else
      @privilege.errors.add(:action, '自分が許可されていない権限は共有出来ません')
    end
    render :new
  end

  private

  def privilege_params
    params.require(:privilege).permit(:user_id, :model, :action)
  end
end
