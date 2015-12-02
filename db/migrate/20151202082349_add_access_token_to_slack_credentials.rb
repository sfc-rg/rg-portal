class AddAccessTokenToSlackCredentials < ActiveRecord::Migration
  def change
    add_column :slack_credentials, :access_token, :string, after: :slack_user_id
  end
end
