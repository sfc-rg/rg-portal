class Privilege < ActiveRecord::Base
  belongs_to :user

  validates :model, presence: true
  validates :action, presence: true
end
