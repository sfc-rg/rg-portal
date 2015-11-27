class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_current_user

  protect_from_forgery with: :exception

  protected

  def store_forwarding_url
    session[:forwarding_url] = request.url if request.get?
  end

  def load_forwarding_url(default_url)
    redirect_to(session[:forwarding_url] || default_url)
    session.delete(:forwarding_url)
  end

  private

  def set_locale
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_current_user
    return unless @current_user.blank?
    store_forwarding_url
    redirect_to '/auth/slack'
  end

  def require_active_current_user
    require_current_user
    redirect_to edit_profile_path if @current_user.present? && !@current_user.active?
  end
end
