OAUTH_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.open(Rails.root.join('config', 'oauth.yml'))))

class SessionController < ApplicationController
  def slack_callback
    auth = request.env['omniauth.auth']

    # >> auth.info.email
    # => "miyukki@sfc.wide.ad.jp"
    # >> auth.info.name
    # => "Yusei Yamanaka"
    # >> auth.info.nickname
    # => "miyukki"
    # >> auth.info.user_id
    # => "U03AE1H0U"
    # >> auth.info.team_id
    # => "T02C4D9FP"

    if OAUTH_CONFIG[:slack][:team_id] != auth.info.team_id
      return render template: 'session/slack_invalid_team'
    end

    slack_credential = SlackCredential.find_or_initialize_by(slack_user_id: auth.info.user_id)
    user = if slack_credential.new_record?
        ldap_info = LdapSupport.ldap_info(auth.info.email.split('@').first)
        ldap_credential = LdapCredential.import(user: nil, info: ldap_info) if ldap_info.present?
        User.create(email: auth.info.email,
                    name: auth.info.name,
                    nickname: auth.info.nickname,
                    icon_url: auth.extra.user_info.user.profile.image_192,
                    slack_credential: slack_credential,
                    ldap_credential: ldap_credential)
      else
        slack_credential.user.update(name: auth.info.name,
                                     nickname: auth.info.nickname,
                                     icon_url: auth.extra.user_info.user.profile.image_192)
        slack_credential.user
      end

    slack_credential.update(username: auth.info.nickname, access_token: auth.credentials.token)

    session[:user_id] = user.id
    load_forwarding_url root_path
  end
end
