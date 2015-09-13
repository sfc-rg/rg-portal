module Emojifier
  def emojify
    self.content.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        ActionController::Base.helpers.image_tag(
          ActionController::Base.helpers.image_path("emoji/#{emoji.image_filename}"),
          alt: match, class: "emoji"
        )
      else
        $1
      end
    end
  end
end
