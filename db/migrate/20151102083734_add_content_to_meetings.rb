class AddContentToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :content, :text
  end
end
