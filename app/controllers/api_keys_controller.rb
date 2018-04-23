class ApiKeysController < ApplicationController
  before_action :require_active_current_user
  before_action :set_api_key, only: :destroy

  def index
    @api_keys = ApiKey.all
  end

  def create
    unless @current_user.has_privilege?('api_keys', 'create')
      return render text: '403 Forbidden', layout: true, status: :forbidden
    end
    api_key = ApiKey.new(user: @current_user)
    api_key.generate_access_token!
    api_key.save!
    redirect_to api_keys_path, flash: { success: t('api_keys.created_msg') }
  rescue => e
    redirect_to api_keys_path, flash: { error: t('error.api_key_create', msg: e.message) }
  end

  def destroy
    unless @api_key.user == @current_user || @current_user.has_privilege?('api_keys', 'destroy')
      return render text: '403 Forbidden', layout: true, status: :forbidden
    end
    @api_key.revoke!
    redirect_to api_keys_path, flash: { success: t('api_keys.revoked_msg') }
  rescue => e
    redirect_to api_keys_path, flash: { error: t('error.api_key_revoke', msg: e.message) }
  end

  private

  def set_api_key
    @api_key = ApiKey.find(params[:id])
  end
end
