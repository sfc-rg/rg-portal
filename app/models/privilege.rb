class Privilege < ActiveRecord::Base
  belongs_to :user

  validates :model, presence: true
  validates :action, presence: true
  validates :user, uniqueness: {
    scope: [:model, :action],
    message: '指定されたユーザはすでにリクエストされた権限を持っています'
  }

  def stringify
    "#{model}##{action}"
  end
end
