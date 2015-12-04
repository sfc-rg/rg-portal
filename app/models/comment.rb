class Comment < ActiveRecord::Base
  include Emojifier
  include MarkdownRender

  belongs_to :user

  validates :user, presence: true
  validates :content, presence: true
end
