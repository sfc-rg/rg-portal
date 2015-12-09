class PresentationCommentsController < CommentsController
  include SlackNotifier

  before_action :set_presentation, only: [:index, :create]
  after_action :notify_new_comment, only: :create
  after_action :notify_mentions, only: :create

  protected

  def list_comments
    @presentation.comments
  end

  def show_path(comment)
    presentation_path(comment.presentation)
  end

  def show_url(comment)
    presentation_url(comment.presentation)
  end

  def notify_new_comment
    super(from: @comment.user, to: @comment.presentation.user, title: @comment.presentation.title)
  end

  def notify_mentions
    super(from: @comment.user, title: @comment.presentation.title)
  end

  private

  def set_presentation
    @presentation = Presentation.find_by(id: params[:presentation_id] || params[:presentation_comment][:presentation_id])
  end
end
