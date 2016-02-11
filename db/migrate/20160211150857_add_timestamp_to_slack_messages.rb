class AddTimestampToSlackMessages < ActiveRecord::Migration
  def change
    add_column :slack_messages, :timestamp, :datetime, after: :message
  end
end
