class Upload < ActiveRecord::Base
  mount_uploader :file, FileUploader
end
