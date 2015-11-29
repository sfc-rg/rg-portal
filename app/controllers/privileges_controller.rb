class PrivilegesController < ApplicationController
  before_action :require_active_current_user

  def new
    @privilege = Privilege.new
  end

  def create
    @privilege = Privilege.new(privilege_params)
    unless @current_user.has_privilege?(@privilege.model, @privilege.action)
      @privilege.errors.add(:action, '自分が許可されていない権限は共有出来ません')
    else
      if @privilege.save
        message = "#{@privilege.user.nickname}に#{@privilege.stringify}の権限を共有しました"
        flash.now[:success] = message
      end
    end
    render :new
  end

  private

  def privilege_params
    params.require(:privilege).permit(:user_id, :model, :action)
  end
end
