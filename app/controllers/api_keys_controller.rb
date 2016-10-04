class ApiKeysController < ApplicationController
  before_action :set_api_key, only: :destroy

  def index
    @api_keys = ApiKey.all
  end

  def create
    unless @current_user.has_privilege?('api_keys', 'create')
      redirect_to api_keys_path, flash: { error: 'APIキーを作成する権限がありません'}
    end
    api_key = ApiKey.new(user: @current_user)
    api_key.generate_access_token
    api_key.save!
    redirect_to api_keys_path, flash: { success: "APIキーを作成しました" }
  rescue => e
    redirect_to api_keys_path, flash: { error: "APIキーの作成に失敗しました\nエラー: #{e.message}" }
  end

  def destroy
    unless @api_key.user == @current_user || @current_user.has_privilege?('api_keys', 'destroy')
      redirect_to api_keys_path, flash: { error: 'APIキーを無効化する権限がありません'}
    end
    @api_key.revoke!
    redirect_to api_keys_path, flash: { success: "APIキーを無効化しました" }
  rescue => e
    redirect_to api_keys_path, flash: { error: "APIキーの無効化に失敗しました\nエラー: #{e.message}" }
  end

  private

  def set_api_key
    @api_key = ApiKey.find(params[:id])
  end
end
