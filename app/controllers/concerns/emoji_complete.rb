module EmojiComplete
  def set_emoji_completion
    gon.emojis = Emoji.send(:names_index).map { |name, emoji| [name, emoji.image_filename] }.to_h
  end
end
