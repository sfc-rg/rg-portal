class CreateGroupsAndGroupUsers < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :kind, null: false

      t.timestamps null: false
    end

    create_table :group_users do |t|
      t.references :group
      t.references :user

      t.timestamps null: false
    end
  end
end
