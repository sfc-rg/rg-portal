class AddTimestampToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :timestamp, :string, after: :content, limit: 14
    add_index :blogs, :timestamp
  end
end
