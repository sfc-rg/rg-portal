module ApplicationHelper
  def css_namespace
    "#{params[:controller]} #{params[:action]}"
  end

  def render_title
    content_for?(:title) ? "#{content_for(:title)} | RG Portal" : 'RG Portal'
  end

  def displayable_datetime(time)
    time.strftime('%Y/%m/%d %H:%M:%S')
  end
end
