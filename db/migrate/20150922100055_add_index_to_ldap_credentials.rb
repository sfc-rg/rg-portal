class AddIndexToLdapCredentials < ActiveRecord::Migration
  def change
    add_index :ldap_credentials, :student_id, unique: true
  end
end
