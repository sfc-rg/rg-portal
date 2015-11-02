class AddTypeAndPresentationIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :type, :string
    add_reference :comments, :presentation, index: true
  end
end
