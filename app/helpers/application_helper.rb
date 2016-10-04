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

  def show_user_badge(user)
    content_tag(:div, class: 'user_badge') do
      concat image_tag(user.icon_url, class: 'user_icon')
      concat content_tag(:span, user.nickname, class: 'user_nickname')
    end
  end
end
