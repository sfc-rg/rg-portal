module SlackNotifier
  NOTIFICATION_USERNAME = 'Portal Notification'

  def slack_notify(from: nil, to: nil, message: '')
    return if from.slack_credential.access_token.blank?
    client = Slack::Client.new(token: from.slack_credential.access_token)
    client.chat_postMessage(username: NOTIFICATION_USERNAME, channel: "@#{to.nickname}", text: message, icon_emoji: ':triangular_flag_on_post:')
  end
end
