class PageHistoriesController < ApplicationController
  include PageSetter
  before_action :set_page
  before_action :set_history, except: :index

  def index
    @histories = PageHistory.where(page: @page).order('created_at DESC')
  end

  def show
  end

  def diff
  end

  private

  def set_history
    @history = PageHistory.find_by(id: params[:id], page: @page)
    redirect_to page_histories_path if @history.blank?
  end
end
