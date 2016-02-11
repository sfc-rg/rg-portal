class SlackMessageMention < ActiveRecord::Base
  belongs_to :slack_message
end
