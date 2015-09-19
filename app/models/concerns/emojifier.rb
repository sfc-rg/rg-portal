module Emojifier
  def emojify
    self.content.gsub(/:([\w+-]+):/) do |match|
      name = Regexp.last_match(1)
      emoji = Emoji.find_by_alias(name)
      next match unless emoji
      ActionController::Base.helpers.image_tag(
        ActionController::Base.helpers.image_path("emoji/#{emoji.image_filename}"),
        alt: name, class: 'emoji'
      )
    end
  end
end
