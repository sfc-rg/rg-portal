class PageCommentsController < CommentsController
  include SlackNotifier

  after_action :notify_mentions, only: :create

  protected

  def show_path(comment)
    page_path(path: comment.page.path)
  end

  def show_url(comment)
    page_url(path: comment.page.path)
  end

  def notify_mentions
    super(from: @comment.user, title: @comment.page.title)
  end
end
