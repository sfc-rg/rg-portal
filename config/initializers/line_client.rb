require 'line/bot'

OAUTH_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.open(Rails.root.join('config', 'oauth.yml')))) unless defined?(OAUTH_CONFIG)

LineClient = Line::Bot::Client.new do |config|
  config.channel_secret = OAUTH_CONFIG.try(:[], :line).try(:[], :beacon).try(:[], :channel_secret)
  config.channel_token = OAUTH_CONFIG.try(:[], :line).try(:[], :beacon).try(:[], :channel_token)
end
