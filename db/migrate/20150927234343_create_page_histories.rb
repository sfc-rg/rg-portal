class CreatePageHistories < ActiveRecord::Migration
  def change
    create_table :page_histories do |t|
      t.references :page, index: true
      t.references :user, index: true
      t.text :path
      t.text :title
      t.text :content_diff
      t.timestamps null: false
    end
  end
end
