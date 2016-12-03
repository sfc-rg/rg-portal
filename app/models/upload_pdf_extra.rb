class UploadPdfExtra < ActiveRecord::Base
  belongs_to :upload

  validates :upload, presence: true, uniqueness: true

  before_save :fetch_extra!

  def fetch_extra!
    return if self.upload.blank?
    reader = PDF::Reader.new(self.upload.file.path)
    return if reader.blank?
    self.pdf_version = reader.pdf_version
    self.num_of_pages = reader.page_count
    self
  end
end
