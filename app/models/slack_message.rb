class SlackMessage < ActiveRecord::Base
  has_many :slack_message_mentions

  searchable do
    text :content do
      message.gsub!(/\p{Cc}/, '')
    end
    text :mention_user do
      slack_message_mentions.map(&:user)
    end
    time :timestamp
  end
end
