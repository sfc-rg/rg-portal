class User < ActiveRecord::Base
  has_one :slack_credential
  has_one :ldap_credential
  has_many :group_users
  has_many :groups, through: :group_users

  enum role: { general: 0, manager: 10, admin: 20 }
  accepts_nested_attributes_for :group_users, allow_destroy: true

  def active?
    self.ldap_credential.present? && self.groups.present?
  end
end
