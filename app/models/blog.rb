class Blog < ActiveRecord::Base
  include Emojifier
  include MarkdownRender

  TIMESTAMP_FORMAT = '%Y%m%d%H%M%S'

  belongs_to :user
  has_many :comments, class_name: BlogComment
  delegate :nickname, to: :user, prefix: :author
  after_create :set_timestamp!

  validates :title, presence: true
  validates :content, presence: true

  def header_level
    2
  end

  def to_param
    { nickname: author_nickname,
      timestamp: timestamp,
    }
  end

  private

  def set_timestamp!
    self.timestamp = created_at.strftime(TIMESTAMP_FORMAT)
    self.save
  end
end
