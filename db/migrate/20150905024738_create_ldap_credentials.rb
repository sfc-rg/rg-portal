class CreateLdapCredentials < ActiveRecord::Migration
  def change
    create_table :ldap_credentials do |t|
      t.references :user, index: true
      t.string :uid
      t.integer :uid_number
      t.integer :gid_number
      t.string :gecos
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
