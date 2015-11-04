class PageCommentsController < CommentsController
  protected

  def show_path(comment)
    page_path(path: comment.page.path)
  end
end
