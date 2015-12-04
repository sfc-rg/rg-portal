class AddAccessTokenToSlackCredentials < ActiveRecord::Migration
  def change
    add_column :slack_credentials, :username, :string, after: :slack_user_id
    add_column :slack_credentials, :access_token, :string, after: :username
  end
end
