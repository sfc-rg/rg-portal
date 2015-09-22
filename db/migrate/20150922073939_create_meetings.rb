class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :name
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.timestamps null: false
    end
  end
end
