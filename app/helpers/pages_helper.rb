module PagesHelper
  def page_breadcrumb_links(page)
    paths = page.path.split('/')
    links = paths.map.with_index do |path, index|
      link = link_to(path, page_path(paths.take(index + 1).join('/')))
      "<div class='link'>#{link}</div>"
    end.join
  end
end
