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
    return if @current_user.present?
    store_forwarding_url
    redirect_to '/auth/slack'
  end

  def require_active_current_user
    require_current_user
    if @current_user.present? && !@current_user.active?
      redirect_to edit_profile_path, flash: { error: "アカウントを有効化するには、rg-netの認証とKGの登録が必要です。" }
    end
  end

  def require_privilege
    return if @current_user.has_privilege?(controller_name, action_name)
    render text: '403 Forbidden', layout: true, status: :forbidden
  end
end
