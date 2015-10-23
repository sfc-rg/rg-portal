module PreBuiltPagesHelper
  def include_or_create_page_content(path, message, options = {})
    options.reverse_merge!(
      edit_link: true
    )

    page = Page.find_by(path: path)
    return "<div><a href='#{edit_page_path(path)}'>#{message}</a></div>" if page.blank?
    edit_button = options[:edit_link] ? "<div class=edit_link><a href='#{edit_page_path(path)}'>このページを編集</a></div>" : ''
    page.render_content + edit_button
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
