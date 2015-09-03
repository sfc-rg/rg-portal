module ApplicationHelper
  def render_title
    content_for?(:title) ? "#{content_for(:title)} | RG Portal" : 'RG Portal'
  end
end
