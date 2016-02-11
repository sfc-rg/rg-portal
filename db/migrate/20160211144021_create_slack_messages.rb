class CreateSlackMessages < ActiveRecord::Migration
  def change
    create_table :slack_messages do |t|
      t.string :pid, index: true
      t.string :room
      t.string :user
      t.text :message
      t.timestamps null: false
    end
  end
end
