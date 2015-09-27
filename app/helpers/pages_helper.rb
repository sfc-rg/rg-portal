module PagesHelper
  def page_breadcrumb_links(page)
    page.paths.map.with_index do |path, index|
      link = link_to(path, page_path(page.paths.take(index + 1).join('/')))
      "<div class='link'>#{link}</div>"
    end.join
  end
end
