class AddMeetingAttendancesCountToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :meeting_attendances_count, :integer, default: 0
  end
end
