class CreateMeetingAttendances < ActiveRecord::Migration
  def change
    create_table :meeting_attendances do |t|
      t.references :meeting, index: true
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
