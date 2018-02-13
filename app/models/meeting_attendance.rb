class MeetingAttendance < ActiveRecord::Base
  belongs_to :meeting, counter_cache: true
  belongs_to :user

  validates :meeting, presence: true
  validates :user, presence: true
  validates :meeting, uniqueness: { scope: :user, message: 'should be unique per user.' }
end
