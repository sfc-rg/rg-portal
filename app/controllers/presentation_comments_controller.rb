class PresentationCommentsController < CommentsController
  protected

  def show_path(comment)
    presentation_path(comment.presentation)
  end
end
