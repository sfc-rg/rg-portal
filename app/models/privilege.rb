class Privilege < ActiveRecord::Base
  belongs_to :user

  validates :model, presence: true
  validates :action, presence: true
  validates :user, uniqueness: {
    scope: [:model, :action],
    message: I18n.t('error.user_already_has_privilege')
  }

  def stringify
    "#{model}##{action}"
  end
end
