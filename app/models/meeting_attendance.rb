class MeetingAttendance < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :user

  validates :meeting, presence: true
  validates :user, presence: true
  validates :meeting, uniqueness: { scope: :user, message: 'should uniqueness per user' }
end
