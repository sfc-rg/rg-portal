class User < ActiveRecord::Base
  has_one :slack_credential
  has_one :ldap_credential

  def active?
    self.ldap_credential.present?
  end
end
