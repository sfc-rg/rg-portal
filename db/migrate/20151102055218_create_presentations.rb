class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.references :user, index: true
      t.references :meeting, index: true
      t.string :title, null: false
      t.timestamps null: false
    end
  end
end
