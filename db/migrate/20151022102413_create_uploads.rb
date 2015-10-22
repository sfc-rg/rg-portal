class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.references :user, index: true
      t.string :file
      t.string :content_type
      t.timestamps null: false
    end
  end
end
