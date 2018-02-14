class PresentationHandout < ActiveRecord::Base
  belongs_to :presentation, touch: true
  belongs_to :upload, dependent: :destroy

  validates :presentation, presence: true
  validates :upload, presence: true
end
