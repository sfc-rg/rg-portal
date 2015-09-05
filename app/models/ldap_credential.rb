class LdapCredential < ActiveRecord::Base
  belongs_to :user

  validates :uid_number, uniqueness: true
end
