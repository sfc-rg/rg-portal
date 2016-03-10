class PagesController < ApplicationController
  include EmojiComplete
  include UserComplete
  include PageSetter
  before_action :require_active_current_user
  before_action :set_page, except: :index
  before_action :set_new_comment, only: :show
  before_action :set_emoji_completion, only: [:show, :edit]
  before_action :set_user_completion, only: [:show, :edit]

  NUM_OF_RECENT_ITEMS = 30

  def index
    @recent_contents = Sunspot.search(Page, Blog) do
      order_by :updated_at, :desc
      paginate per_page: NUM_OF_RECENT_ITEMS
    end
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

  def rename
  end

  private

  def set_new_comment
    @comment = PageComment.new(page: @page) if @page.present?
  end

  def page_params
    params.require(:page).permit(:path, :title, :content).merge(user: @current_user)
  end
end
