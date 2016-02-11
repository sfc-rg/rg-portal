class CreateSlackMessageMentions < ActiveRecord::Migration
  def change
    create_table :slack_message_mentions do |t|
      t.references :slack_message, index: true
      t.string :user
      t.timestamps null: false
    end
  end
end
