class Comment < ActiveRecord::Base
  include Emojifier
  include MarkdownRender

  belongs_to :user
  belongs_to :page

  after_save :notify_mentions

  validates :content, presence: true

  MENTION_USER_REGEX = /@[A-z0-9]+/

  private

  def notify_mentions
    usernames = self.content.scan(MENTION_USER_REGEX).map { |mention| mention[0] }
    users = usernames.map { |username| User.find_by(nickname: username) }.compact
    # users.each do |user|
      # Slack.notify()
    # end
  end
end
