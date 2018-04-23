class UserJudgement < ActiveRecord::Base
  belongs_to :presentation
  belongs_to :user

  validates :user, uniqueness: { scope: :presentation, message: 'should be unique per presentation.' }

  def stringify
    passed ? 'PASS' : 'FAIL'
  end
end
