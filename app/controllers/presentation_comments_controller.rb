class PresentationCommentsController < CommentsController
  before_action :set_presentation, only: :index

  def index
    return render json: { html: nil }, status: 404 if @presentation.blank?
    html = render_to_string(
      partial: 'comments/list',
      locals: {
        comments: @presentation.comments,
        new_comment: PresentationComment.new(presentation: @presentation),
      }
    )
    render json: { html: html }
  end

  protected

  def show_path(comment)
    presentation_path(comment.presentation)
  end

  private

  def set_presentation
    @presentation = Presentation.find_by(id: params[:presentation_id])
  end
end
