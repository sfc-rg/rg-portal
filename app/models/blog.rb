class Blog < ActiveRecord::Base
  include Emojifier
  include MarkdownRender

  TIMESTAMP_FORMAT = '%Y%m%d%H%M%S%6N'

  belongs_to :user
  has_many :comments, class_name: BlogComment

  def header_level
    2
  end

  def nickname
    user.try(:nickname)
  end

  def timestamp
    created_at.strftime(TIMESTAMP_FORMAT)
  end

  def to_param
    { nickname: nickname,
      timestamp: timestamp,
    }
  end
end
