class PresentationHandout < ActiveRecord::Base
  belongs_to :presentation
  belongs_to :upload

  validates :presentation, presence: true
  validates :upload, presence: true
end
