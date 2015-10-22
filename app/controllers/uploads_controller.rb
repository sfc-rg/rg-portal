class UploadsController < ApplicationController
  before_action :require_active_current_user
  before_action :set_page, only: :index

  NUM_OF_UPLOADS_PER_PAGE = 10

  def index
    @uploads = Upload.order('created_at DESC').page(@page).per(NUM_OF_UPLOADS_PER_PAGE)
  end

  def create
    @upload = Upload.new(upload_params)
    @upload.save # implement this
    redirect_to action: :index
  end

  def show
    @upload = Upload.find_by(id: params[:id])
    return render nothing: true if @upload.blank?

    send_data File.open(@upload.file.current_path).read,
      type: @upload.content_type, disposition: :inline
  end

  private

  def set_page
    @page = [params[:page].to_i, 1].max
  end

  def upload_params
    params.require(:upload).permit(:file).merge(user: @current_user)
  end
end
