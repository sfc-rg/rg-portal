module SlackNotifier
  DEFAULT_CHANNEL = Rails.env.production? ? '#random' : '#portal'
  NOTIFICATION_USERNAME = 'Portal Notification'

  def slack_notify(from: nil, to: nil, message: '')
    return if from.slack_credential.access_token.blank?
    channel = to.is_a?(User) ? "@#{to.nickname}" : (to || DEFAULT_CHANNEL)
    client = Slack::Client.new(token: from.slack_credential.access_token)
    client.chat_postMessage(
      username: NOTIFICATION_USERNAME,
      channel: channel,
      text: message,
      icon_emoji: ':triangular_flag_on_post:',
    )
  end
end
