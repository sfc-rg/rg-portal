class Blog < ActiveRecord::Base
  include Emojifier
  include MarkdownRender

  belongs_to :user
  has_many :comments

  def header_level
    2
  end

  def nickname
    user.try(:nickname)
  end

  def timestamp
    created_at.strftime('%Y%m%d%H%M%S%6N')
  end

  def to_param
    # timestamp
    { nickname: nickname,
      timestamp: timestamp,
    }
  end
end
