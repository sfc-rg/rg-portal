class ResetMeetingAttendancesCounter < ActiveRecord::Migration
  def up
    Meeting.find_each do |meeting|
      Meeting.reset_counters(meeting.id, :meeting_attendances)
    end
  end

  def down
  end
end
