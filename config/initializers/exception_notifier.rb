if Rails.env.production?
  EN_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.open(Rails.root.join('config', 'exception_notifier.yml'))))

  Rails.application.config.middleware.use ExceptionNotification::Rack,
    slack: {
      webhook_url: EN_CONFIG[:slack][:webhook_url],
      channel: EN_CONFIG[:slack][:channel],
      additional_parameters: {
        icon_emoji: ':exclamation:',
        mrkdwn: true,
      }
    }
end
