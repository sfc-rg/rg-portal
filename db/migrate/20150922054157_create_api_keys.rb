class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.references :user, index: true
      t.string :name
      t.string :access_token, limit: 32, index: true
      t.timestamps null: false
    end
  end
end
