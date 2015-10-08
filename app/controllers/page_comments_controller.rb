<<<<<<< 97050d636ce714991b0423127c02b9caa8b4d049
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
=======
class PageCommentsController < ApplicationController
  before_action :require_active_current_user

  def create
    @page_comment = PageComment.create(page_comment_params)

    redirect_to page_path(path: @page_comment.page.path)
  end

  private

  def page_comment_params
    params.require(:page_comment).permit(:page_id, :content).merge({ user: @current_user })
>>>>>>> Add blog and blog comment model
  end

  def set_page
    @page = Page.find_by(id: params[:page_comment][:page_id])
  end
end
