class AddAcceptingToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :accepting, :boolean, default: true, null: false
  end
end
