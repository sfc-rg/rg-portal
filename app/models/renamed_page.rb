class RenamedPage < ActiveRecord::Base
  def self.find_page(before_path)
    renaming = self.find_by(before_path: before_path)
    return nil if renaming.blank?

    after_page = Page.find_by(path: renaming.after_path)
    self.find_page(renaming.after_path) || after_page
  end
end
