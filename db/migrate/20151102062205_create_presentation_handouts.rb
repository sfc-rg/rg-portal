class CreatePresentationHandouts < ActiveRecord::Migration
  def change
    create_table :presentation_handouts do |t|
      t.references :presentation, index: true
      t.references :upload, index: true
      t.timestamps null: false
    end
  end
end
