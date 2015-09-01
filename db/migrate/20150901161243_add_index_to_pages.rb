class AddIndexToPages < ActiveRecord::Migration
  def change
    add_index :pages, :content
  end
end
