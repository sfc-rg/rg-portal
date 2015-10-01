module PageSetter
  def set_page
    @page = Page.find_by(path: params[:path])
    return if @page.present?

    @renamed_page = RenamedPage.find_page(params[:path])
    redirect_to page_path(path: @renamed_page.path) if @renamed_page.present?
  end
end
