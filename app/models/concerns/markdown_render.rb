module MarkdownRender
  MARKDOWN_RENDER_OPTIONS = { tables: true, autolink: true }
  HTML_RENDER_OPTIONS = { hard_wrap: true }

  def render_content
    Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(HTML_RENDER_OPTIONS), MARKDOWN_RENDER_OPTIONS).render(self.content)
  end
end
