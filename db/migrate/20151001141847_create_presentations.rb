class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.string :title
      t.integer :number
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
