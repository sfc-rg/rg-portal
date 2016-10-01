class UserJudgement < ActiveRecord::Base
  belongs_to :presentation
  belongs_to :user

  validates :user, uniqueness: { scope: :presentation, message: 'should uniqueness per presentation' }

  def stringify
    passed ? 'PASS' : 'FAIL'
  end
end
