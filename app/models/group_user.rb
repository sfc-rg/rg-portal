class GroupUser < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validates :group, uniqueness: { scope: :user, message: 'should be unique per user.' }
end
