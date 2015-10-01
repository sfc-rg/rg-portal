class UploadFile < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :attached_object, polymorphic: true
end
