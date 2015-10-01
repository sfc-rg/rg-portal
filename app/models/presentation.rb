class Presentation < ActiveRecord::Base
  has_many :comments, class: PresentationComment
  belongs_to :user
end
