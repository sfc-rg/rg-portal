require 'line/bot'

OAUTH_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.open(Rails.root.join('config', 'oauth.yml'))))

LineClient = Line::Bot::Client.new do |config|
  config.channel_secret = config.try(:line).try(:beacon).try(:channel_secret)
  config.channel_token = config.try(:line).try(:beacon).try(:channel_token)
end
