class SettingsController < ApplicationController
  before_action :require_current_user

  STUDENT_ID_PATTERN = /7\d{7}/

  def edit_profile
  end

  def update_profile
    ldap = params.require(:ldap).permit(:username, :password)

    unless LdapSupport.ldap_bind(ldap[:username], ldap[:password])
      flash[:error] = '認証情報が正しくありません'
      return redirect_to edit_profile_path
    end

    info = LdapSupport.ldap_info(ldap[:username])
    credential = LdapCredential.new(
      user: @current_user,
      uid: info[:uid],
      uid_number: info[:uidnumber],
      gid_number: info[:gidnumber],
      gecos: info[:gecos],
      student_id: info[:gecos].match(STUDENT_ID_PATTERN).to_s,
    )

    unless credential.save
      flash[:error] = '認証情報の保存で問題が発生しました'
      return redirect_to edit_profile_path
    end

    redirect_to edit_profile_path
  end
end
