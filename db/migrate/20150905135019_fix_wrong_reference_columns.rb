class FixWrongReferenceColumns < ActiveRecord::Migration
  def change
    remove_index :slack_credentials, name: :index_slack_credentials_on_users_id
    rename_column :slack_credentials, :user_id, :slack_user_id
    rename_column :slack_credentials, :users_id, :user_id
    add_index :slack_credentials, [:user_id], name: :index_slack_credentials_on_user_id

    remove_index :pages, name: :index_pages_on_users_id
    rename_column :pages, :users_id, :user_id
    add_index :pages, [:user_id], name: :index_pages_on_user_id
  end
end
