class Page < ActiveRecord::Base
  has_many :comments

  validates :content, presence: true

  scope :recent, -> { order('pages.created_at DESC') }

  def render_content
    # GitHub::Markdown.render(self.content)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true).render(self.content)
  end
end
