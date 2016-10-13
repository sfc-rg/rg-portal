class CreateLineCredentials < ActiveRecord::Migration
  def change
    create_table :line_credentials do |t|
      t.references :user, index: true
      t.string :encrypted_line_user_id
      t.string :display_name
      t.text :picture_url
      t.string :associate_key
      t.timestamps null: false
      t.datetime :unfollowed_at
    end
  end
end
