module PreBuiltPagesControllerHelper
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
    term = 2 < today.month || today.month < 9 ? 's' : 'f'
    "#{today.year}#{term}"
  end
end
