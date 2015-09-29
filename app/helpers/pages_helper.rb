module PagesHelper
  def page_breadcrumb_links(page)
    page.paths.map.with_index do |path, index|
      link = link_to(path, page_path(page.paths.take(index + 1).join('/')))
      "<div class='link'>#{link}</div>"
    end.join
  end

  def diff_html(method, source, target)
    Diffy::Diff.new(source.send(method), target.send(method)).to_s(:html).html_safe
  end
end
