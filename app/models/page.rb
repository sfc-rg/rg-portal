class Page < ActiveRecord::Base
  has_many :comments

  validates :content, presence: true

  def render_content
    # GitHub::Markdown.render(self.content)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true).render(self.content)
  end
end
