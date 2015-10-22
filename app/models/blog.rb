class Blog < ActiveRecord::Base
  include Emojifier
  include MarkdownRender

  belongs_to :user
  has_many :comments

  def timestamp
    created_at.to_i
  end

  def to_param
    { nickname: user.try(:nickname),
      timestamp: timestamp,
    }
  end
end
