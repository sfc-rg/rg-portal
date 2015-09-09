class SettingsController < ApplicationController
  before_action :require_current_user

  def edit_profile
  end

  def update_ldap
    ldap = params.require(:ldap).permit(:username, :password)

    unless LdapSupport.ldap_bind(ldap[:username], ldap[:password])
      flash[:error] = '認証情報が正しくありません'
      return redirect_to edit_profile_path
    end

    info = LdapSupport.ldap_info(ldap[:username])
    unless LdapCredential.import(user: @current_user, info: info).save
      flash[:error] = '認証情報の保存で問題が発生しました'
      return redirect_to edit_profile_path
    end

    redirect_to edit_profile_path
  end

  def update_profile
    @current_user.group_users.destroy_all
    @current_user.update(user_params)
    redirect_to edit_profile_path
  end

  private

  def user_params
    params.require(:user).permit(group_users_attributes: [:group_id, :_destroy])
  end
end
