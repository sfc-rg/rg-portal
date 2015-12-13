class UploadsController < ApplicationController
  before_action :require_active_current_user
  before_action :set_page, only: :index
  before_action :set_upload, only: [:show, :file]
  before_action :check_filename, only: [:show, :file]

  NUM_OF_UPLOADS_PER_PAGE = 10

  def index
    @uploads = Upload.order('created_at DESC').page(@page).per(NUM_OF_UPLOADS_PER_PAGE)
  end

  def create
    @upload = Upload.new(upload_params)
    @upload.save # implement this

    if request.xhr?
      json = {
        upload: {
          id: @upload.id,
          url: file_upload_url(@upload, filename: @upload.file.file.filename),
        }
      }
      render json: json
    else
      redirect_to action: :index
    end
  end

  def show
    redirect_to file_upload_path(@upload, filename: @upload.file.file.filename)
  end

  def file
    send_file @upload.file.current_path, type: @upload.content_type, disposition: :inline
  end

  private

  def set_page
    @page = [params[:page].to_i, 1].max
  end

  def set_upload
    @upload = Upload.find_by(id: params[:id])
    return render nothing: true if @upload.blank?
  end

  def check_filename
    filename = [ params[:filename], params[:format] ].compact.join('.')
    if filename != @upload.file.file.filename
      return redirect_to file_upload_path(@upload, filename: @upload.file.file.filename)
    end
  end

  def upload_params
    params.require(:upload).permit(:file).merge(user: @current_user)
  end
end
