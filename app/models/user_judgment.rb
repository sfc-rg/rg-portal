class UserJudgment < ActiveRecord::Base
  belongs_to :presentation
  belongs_to :user

  validates :user, uniqueness: { scope: :presentation, message: 'should uniqueness per presentation' }
  validates :passed, presence: true
end
