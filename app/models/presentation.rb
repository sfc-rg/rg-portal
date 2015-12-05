class Presentation < ActiveRecord::Base
  belongs_to :user
  belongs_to :meeting
  delegate :juried, to: :meeting
  has_many :comments, class_name: 'PresentationComment'
  has_many :user_judgements, dependent: :destroy
  has_many :presentation_handouts, dependent: :destroy
  has_many :handouts, through: :presentation_handouts, source: :upload
  accepts_nested_attributes_for :presentation_handouts, allow_destroy: true
  accepts_nested_attributes_for :handouts, allow_destroy: true

  validates :title, presence: true
  validates :user, presence: true
  validates :meeting, presence: true

  def judgement_by(user)
    user_judgements.find_by(user_id: user.id)
  end
end
