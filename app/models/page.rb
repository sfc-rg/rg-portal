class Page < ActiveRecord::Base
  include Emojifier
  include MarkdownRender

  has_many :comments
  has_many :likes
  scope :recent, -> { order('pages.created_at DESC') }

  validates :path, presence: true, uniqueness: true
  validates :content, presence: true

  before_save :create_renamed_page, if: :renamed?

  def like_by(user)
    self.likes.find_by(user: user)
  end

  def paths
    self.path.split('/')
  end

  def subpages
    self.class.where('path LIKE ?', "#{self.path}/%")
  end

  private

  def renamed?
    self.path_changed? && self.path_was.present?
  end

  def create_renamed_page
    RenamedPage.create(before_path: self.path_was, after_path: self.path)
  end
end
