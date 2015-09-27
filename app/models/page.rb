class Page < ActiveRecord::Base
  include Emojifier
  include MarkdownRender

  has_many :comments
  has_many :likes

  validates :content, presence: true

  scope :recent, -> { order('pages.created_at DESC') }

  def like_by(user)
    self.likes.find_by(user: user)
  end

  def paths
    self.path.split('/')
  end

  def subpages
    self.class.where('path LIKE ?', "#{self.path}/%")
  end
end
