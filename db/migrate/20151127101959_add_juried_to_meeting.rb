class AddJuriedToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :juried, :boolean, default: false, null: false
  end
end
