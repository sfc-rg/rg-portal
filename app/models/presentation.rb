class Presentation < ActiveRecord::Base
  belongs_to :user
  belongs_to :meeting

  validates :title, presence: true
  validates :user, presence: true
  validates :meeting, presence: true
end
