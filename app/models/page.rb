class Page < ActiveRecord::Base
  has_many :comments
  has_many :likes

  validates :content, presence: true

  scope :recent, -> { order('pages.created_at DESC') }

  def like_by(user)
    self.likes.find_by(user: user)
  end

  def render_content
    # GitHub::Markdown.render(self.content)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true, autolink: true).render(self.content)
  end
end
