class SettingsController < ApplicationController
  before_action :require_current_user

  def edit_profile
  end

  def update_profile
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
end
