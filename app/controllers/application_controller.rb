class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_current_user

  protect_from_forgery with: :exception

  private

  def set_locale
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_current_user
    redirect_to '/auth/slack' if @current_user.blank?
  end

  def require_active_current_user
    require_current_user
    redirect_to edit_profile_path if @current_user.present? && !@current_user.active?
  end
end
