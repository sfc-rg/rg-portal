class AddOrderToPresentation < ActiveRecord::Migration
  def change
    add_column :presentations, :order, :integer, default: 1, null: false
  end
end
