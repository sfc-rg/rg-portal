class GroupUser < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validates :group, uniqueness: { scope: :user, message: 'should uniqueness per user' }
end
