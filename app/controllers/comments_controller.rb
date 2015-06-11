class CommentsController < ApplicationController
  before_action :require_current_user, only: :create

  def create
    options = comments_params.merge({
      user: @current_user
    })
    @comment = Comment.create(options)

    redirect_to page_path(path: @comment.page.path)
  end

  private

  def comments_params
    params.require(:comment).permit(:page_id, :content)
  end
end
