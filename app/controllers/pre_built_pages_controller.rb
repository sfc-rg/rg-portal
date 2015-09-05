class PreBuiltPagesController < ApplicationController
  before_action :require_active_current_user

  def top
    @recent_pages = Page.recent.limit(10).each
  end

  def wip_term
  end

  def thesis
  end
end
