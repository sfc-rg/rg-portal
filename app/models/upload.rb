class Upload < ActiveRecord::Base
  belongs_to :user
  has_one :pdf_extra, class_name: UploadPdfExtra

  validates :user, presence: true

  mount_uploader :file, FileUploader
  before_save :set_content_type, if: :file_changed?
  before_save :set_pdf_extra, if: :file_changed?

  def image?
    self.content_type.include?('image')
  end

  def pdf?
    self.content_type.include?('pdf')
  end

  def to_param
    {
      id: self.id,
      filename: self.file.file.filename,
    }
  end

  private

  def set_pdf_extra
    return unless self.pdf?
    if self.pdf_extra
      self.pdf_extra.fetch_extra!
    else
      self.pdf_extra = self.build_pdf_extra
    end
  end

  def set_content_type
    self.content_type = self.file.content_type
  end
end
