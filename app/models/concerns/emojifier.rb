module Emojifier
  def emojify
    self.content.gsub(/:([\w+-]+):/) do |match|
      emoji = Emoji.find_by_alias(Regexp.last_match(1))
      return match[1] unless emoji
      ActionController::Base.helpers.image_tag(
        ActionController::Base.helpers.image_path("emoji/#{emoji.image_filename}"),
        alt: match, class: 'emoji'
      )
    end
  end
end
