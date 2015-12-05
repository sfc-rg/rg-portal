class Upload < ActiveRecord::Base
  belongs_to :user

  mount_uploader :file, FileUploader
  before_save :set_content_type, if: :file_changed?

  def image?
    self.content_type.include?('image')
  end

  def pdf?
    self.content_type.include?('pdf')
  end

  private

  def set_content_type
    self.content_type = self.file.content_type
  end
end
