class CommentsController < ApplicationController
  before_action :require_active_current_user

  def create
    @comment = comment_class.create(comment_params)
    redirect_to show_path(@comment)
  end

  private

  def type
    params[:type]
  end

  def comment_class
    type.constantize
  end

  def comment_params
    params.require(type.underscore.to_sym).permit(
      :page_id, :presentation_id, :content
    ).merge(user: @current_user)
  end
end
