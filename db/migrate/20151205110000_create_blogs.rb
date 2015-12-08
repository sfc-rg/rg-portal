class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.references :user, index: true
      t.text :title
      t.text :content

      t.timestamps null: false
    end

    add_column :comments, :blog_id, :integer, index: true, after: :page_id
  end
end
