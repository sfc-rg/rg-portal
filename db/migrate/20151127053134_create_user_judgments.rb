class CreateUserJudgments < ActiveRecord::Migration
  def change
    create_table :user_judgments do |t|
      t.references :presentation, index: true
      t.references :user, index: true
      t.boolean :passed

      t.timestamps null: false
    end

    add_index :user_judgments, [:presentation_id, :user_id], unique: true
  end
end
