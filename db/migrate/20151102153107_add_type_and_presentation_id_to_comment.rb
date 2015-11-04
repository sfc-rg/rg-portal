class AddTypeAndPresentationIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :type, :string
    add_column :comments, :presentation_id, :integer, after: :page_id
    add_index :comments, :presentation_id
  end
end
