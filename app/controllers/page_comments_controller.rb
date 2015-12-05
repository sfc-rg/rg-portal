class PageCommentsController < CommentsController
  include SlackNotifier

  before_action :set_page, only: [:index, :create]
  after_action :notify_mentions, only: :create

  protected

  def list_comments
    @page.comments
  end

  def show_path(comment)
    page_path(path: comment.page.path)
  end

  def show_url(comment)
    page_url(path: comment.page.path)
  end

  def notify_mentions
    super(from: @comment.user, title: @comment.page.title)
  end

  def set_page
    @page = Page.find_by(id: params[:page_comment][:page_id])
  end
end
