module PreBuiltPagesHelper
  def include_page_content(path, default = nil)
    page = Page.find_by(path: path)
    return default if page.blank?
    page.render_content
  end

  def include_or_create_page_content(path, message)
    include_page_content(
      path,
      "<div><a href='#{edit_page_path(path)}'>#{message}</a></div>"
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
