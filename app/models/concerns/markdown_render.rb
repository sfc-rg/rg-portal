module MarkdownRender
  MARKDOWN_RENDER_OPTIONS = { tables: true, autolink: true, fenced_code_blocks: true }
  HTML_RENDER_OPTIONS = { hard_wrap: true }

  def header_level
    1
  end

  def render_content
    content = self.class.include?(Emojifier) ? emojify : self.content
    content = content.gsub(/^#+/, '\0' + '#' * (header_level - 1))
    Redcarpet::Markdown.new(CustomizeRender.new(HTML_RENDER_OPTIONS), MARKDOWN_RENDER_OPTIONS).render(content)
  end

  class CustomizeRender < Redcarpet::Render::HTML
    def block_code(code, language)
      code.gsub!(/\r?\n/, '&#x000A;')
      "<div><pre><code class=\"language-#{language}\">#{code}</code></pre></div>"
    end
  end
end
