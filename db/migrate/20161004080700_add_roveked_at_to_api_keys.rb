class AddRovekedAtToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :revoked_at, :datetime, after: :updated_at, null: true
    add_index :api_keys, :revoked_at
  end
end
