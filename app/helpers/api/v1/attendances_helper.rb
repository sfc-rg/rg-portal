module Api::V1::AttendancesHelper
  def attendance_count(user)
    MeetingAttendance.where(user: user).count
  end
end
