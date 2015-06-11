class CommentsController < ApplicationController
  before_action :require_current_user

  def create
    @comment = Comment.create(comment_params)

    redirect_to page_path(path: @comment.page.path)
  end

  private

  def comment_params
    params.require(:comment).permit(:page_id, :content).merge({ user: @current_user })
  end
end
