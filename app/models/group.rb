class Group < ActiveRecord::Base
  enum kind: { other: 0, kg: 10, rg: 20 }
  has_many :group_users
  has_many :users, through: :group_users

  validates :name, uniqueness: true
end
