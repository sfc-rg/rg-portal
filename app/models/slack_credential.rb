class SlackCredential < ActiveRecord::Base
  belongs_to :user

  validates :slack_user_id, uniqueness: true
end
