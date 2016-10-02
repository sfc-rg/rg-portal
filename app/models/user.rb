class User < ActiveRecord::Base
  has_one :slack_credential, dependent: :destroy
  has_one :ldap_credential, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :blogs
  has_many :groups, through: :group_users
  has_many :privileges, dependent: :destroy

  accepts_nested_attributes_for :group_users, allow_destroy: true

  def active?
    self.ldap_credential.present? && self.groups.present?
  end

  def has_privilege?(model, action = nil)
    if action.present?
      privileges.where(model: model, action: action).present?
    else
      privileges.where(model: model).present?
    end
  end
end
