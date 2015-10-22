class UploadsController < ApplicationController
  before_action :require_active_current_user

  def index
    @uploads = Upload.all
  end

  def create
    @upload = Upload.new(upload_params)
    @upload.save
    # if @upload
    redirect_to action: :index
  end

  def show
  end

  private

  def upload_params
    params.require(:upload).permit(:file).merge(user: @current_user)
  end
end
