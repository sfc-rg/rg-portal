class PageHistory < ActiveRecord::Base
  include MarkdownRender
  belongs_to :page
  belongs_to :user

  def content
    diffs = PageHistory.where(page: page).where('id > ?', id).order('id DESC').pluck(:content_diff)
    diffs.inject(page.content) do |content, diff|
      Diffman.new.patch(content, diff, reverse: true)
    end
  end

  def previous
    @previous ||=
      PageHistory.where(page: page).where('id < ?', id).order('id DESC').first
  end

  def next
    @next ||=
      PageHistory.where(page: page).where('id > ?', id).order('id ASC').first
  end
end
