class Presentation < ActiveRecord::Base
  has_many :comments, class: PresentationComment
  has_one :slide, class: UploadFile, as: :attached_object
  accepts_nested_attributes_for :slide
  has_one :handout, class: UploadFile, as: :attached_object
  accepts_nested_attributes_for :handout
  belongs_to :user
end
