module BlogsHelper
  def blog_title_date(blog)
    blog.created_at.strftime('%Y/%m/%d')
  end
end
