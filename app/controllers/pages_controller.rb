class PagesController < ApplicationController
  include EmojiComplete
  before_action :require_active_current_user
  before_action :set_page, only: [:show, :edit, :update, :rename]
  before_action :set_new_comment, only: :show
  before_action :set_emoji_completion, only: [:show, :edit]

  def index
    @pages = Page.all
  end

  def show
  end

  def edit
    @page = Page.new(path: params[:path]) if @page.blank?
  end

  def update
    if @page.blank?
      @page = Page.create(page_params)
    else
      @page.update(page_params)
    end

    redirect_to page_path(path: @page.path)
  end

  private

  def set_page
    @page = Page.find_by(path: params[:path])
    return if @page.present?

    @renamed_page = RenamedPage.find_page(params[:path])
    redirect_to page_path(path: @renamed_page.path) if @renamed_page.present?
  end

  def set_new_comment
    @comment = Comment.new(page: @page) if @page.present?
  end

  def page_params
    params.require(:page).permit(:path, :title, :content)
  end
end
