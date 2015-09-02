module PagesHelper
  def include_page_content(path, default=nil)
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

  def page_breadcrumb_links(page)
    paths = page.path.split('/')
    links = paths.map.with_index do |path, index|
      link = link_to(path, page_path(paths.take(index + 1).join('/')))
      "<div class='link'>#{link}</div>"
    end.join
  end

  def term_name
    today = Date.today
    term = 2 < today.month || today.month < 9 ? "s" : "f"
    return "#{today.year}#{term}"
  end
end
