class ApplicationController < ActionController::Base
  before_action :set_current_user

  protect_from_forgery with: :exception

  private

  def set_current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_current_user
    redirect_to '/auth/slack' if @current_user.blank?
  end
end
