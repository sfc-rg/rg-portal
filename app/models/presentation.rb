class Presentation < ActiveRecord::Base
  belongs_to :user
  belongs_to :meeting
  has_many :presentation_handouts
  has_many :handouts, through: :presentation_handouts, source: :upload
  accepts_nested_attributes_for :presentation_handouts, allow_destroy: true
  accepts_nested_attributes_for :handouts, allow_destroy: true

  validates :title, presence: true
  validates :user, presence: true
  validates :meeting, presence: true
end
