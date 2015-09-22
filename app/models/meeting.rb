class Meeting < ActiveRecord::Base
  has_many :meeting_attendances
  has_many :attendances, through: :meeting_attendances, source: :user

  scope :current, -> { find_by('start_at > ? AND end_at < ?', Time.now, Time.now) }

  validates :name, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :validate_datetime

  private

  def validate_datetime
    return if start_at.blank? || end_at.blank?
    if start_at > end_at
      errors.add(:end_at, 'must be greater than start_at')
    end
  end
end
