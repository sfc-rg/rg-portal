class PreBuiltPagesController < ApplicationController
  before_action :require_active_current_user, except: :newcomer

  def wip_term
  end

  def thesis
  end

  def newcomer
  end
end
