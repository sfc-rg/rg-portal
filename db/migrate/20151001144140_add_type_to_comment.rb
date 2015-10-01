class AddTypeToComment < ActiveRecord::Migration
  def change
    add_column :comments, :type, :string
  end
end
