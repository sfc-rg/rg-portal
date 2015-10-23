module PreBuiltPagesHelper
  def include_page_content(path, default = nil, postfix = '')
    page = Page.find_by(path: path)
    return default if page.blank?
    page.render_content + postfix
  end

  def include_or_create_page_content(path, message, options = {})
    include_page_content(
      path,
      "<div><a href='#{edit_page_path(path)}'>#{message}</a></div>",
      options[:edit_link] ? "<div class=edit_link><a href='#{edit_page_path(path)}'>このページを編集</a></div>" : ''
    )
  end

  def term_name
    today = Date.today
    if today.month < 3
      "#{today.year - 1}f"
    elsif today.month > 8
      "#{today.year}f"
    else
      "#{today.year}s"
    end
  end
end
