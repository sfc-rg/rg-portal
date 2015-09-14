module Emojifier
  def emojify
    self.content.gsub(/:([\w+-]+):/) do |match|
      emoji = Emoji.find_by_alias(Regexp.last_match(1))
      if emoji
        return ActionController::Base.helpers.image_tag(
          ActionController::Base.helpers.image_path("emoji/#{emoji.image_filename}"),
          alt: match, class: 'emoji'
        )
      end
      match[1]
    end
  end
end
