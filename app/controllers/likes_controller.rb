class LikesController < ApplicationController
  before_action :require_active_current_user
  before_action :set_like

  def create
    return redirect_to root_path if @like.present? # raise error

    @like = Like.create(like_params)
    redirect_to page_path(path: @like.page.path)
  end

  def destroy
    return redirect_to root_path if @like.blank? # raise error

    @like.destroy
    redirect_to page_path(path: @like.page.path)
  end

  private

  def set_like
    @like = Like.find_by(page_id: params[:like][:page_id], user: @current_user)
  end

  def like_params
    params.require(:like).permit(:page_id).merge(user: @current_user)
  end
end
