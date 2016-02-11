class SlackMessage < ActiveRecord::Base
  has_many :slack_message_mentions
end
