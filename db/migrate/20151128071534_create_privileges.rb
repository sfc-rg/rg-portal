class CreatePrivileges < ActiveRecord::Migration
  def change
    create_table :privileges do |t|
      t.string :model, null: false
      t.string :action, null: false
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :privileges, [:model, :action, :user_id]
  end
end
