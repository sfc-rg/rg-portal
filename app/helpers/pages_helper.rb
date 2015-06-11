module PagesHelper
  def include_page_content(path)
    page = Page.find_by(path: path)
    page.render_content
  end
end
