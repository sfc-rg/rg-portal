class Page < ActiveRecord::Base
  include Emojifier
  include MarkdownRender

  belongs_to :user
  has_many :comments, class_name: 'PageComment'
  has_many :likes
  has_many :histories, class_name: PageHistory
  scope :recent, -> { order('pages.created_at DESC') }

  validates :path, presence: true, uniqueness: true
  validates :content, presence: true

  after_save :create_renamed_page, if: :renamed?
  after_save :create_page_history, if: :changed?

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

  def create_page_history
    content_diff = Diffman.new.diff(self.content_was, self.content)
    PageHistory.create(page: self, user: self.user, path: self.path, title: self.title, content_diff: content_diff)
  end
end
