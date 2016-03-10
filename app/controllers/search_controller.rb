class SearchController < ApplicationController
  before_action :require_active_current_user
  before_action :set_keyword, only: :show

  def index

  end

  def show
    @search = Sunspot.search(Page, Blog, SlackMessage) do
      fulltext params[:keyword]
    end
  end

  private

  def set_keyword
    @keyword = params[:keyword]
  end
end
