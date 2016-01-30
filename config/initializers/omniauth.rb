OAUTH_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.open(Rails.root.join('config', 'oauth.yml'))))

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, OAUTH_CONFIG[:slack][:client_id], OAUTH_CONFIG[:slack][:client_secret],
    team: OAUTH_CONFIG[:slack][:team_id], scope: 'channels:read chat:write:bot chat:write:user users:read team:read'
end
