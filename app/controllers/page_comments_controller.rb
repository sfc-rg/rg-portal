class PageCommentsController < CommentsController
  include SlackNotifier

  after_action :notify_mentions, only: :create

  protected

  def show_path(comment)
    page_path(path: comment.page.path)
  end

  private

  def notify_mentions
    usernames = @comment.content.scan(MENTION_USER_REGEX).map { |mention| mention[0] }
    mention_users = usernames.map { |username| User.find_by(nickname: username) }.compact
    mention_users.each do |mention_user|
      url = page_url(path: @comment.page.path)
      message = "New mention on #{@comment.page.title} by #{@comment.user.nickname} #{url}\n#{@comment.content}"
      slack_notify(from: @comment.user, to: mention_user, message: message)
    end
  end
end
