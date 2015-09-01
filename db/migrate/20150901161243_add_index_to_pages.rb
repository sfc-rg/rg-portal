class AddIndexToPages < ActiveRecord::Migration
  def change
    add_index :pages, :content, length: { content: 255 }
  end
end
