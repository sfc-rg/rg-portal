class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  storage :file
  process :set_content_type

  def store_dir
    "upload_files/#{model.id}"
  end
end
