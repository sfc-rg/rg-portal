OAUTH_CONFIG = YAML.load(File.open(Rails.root.join('config', 'oauth.yml')))

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, OAUTH_CONFIG[:slack][:client_id], OAUTH_CONFIG[:slack][:client_secret], scope: :client, team: OAUTH_CONFIG[:slack][:team_id]
end
