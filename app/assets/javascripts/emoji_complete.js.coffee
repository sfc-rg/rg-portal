ready = ->
  emojiCompletions = $('textarea.emoji-complete')
  if emojiCompletions.length > 0
    emojiAliases = Object.keys(gon.emojis)
    emojiCompletions.textcomplete([
      match: /(^|\s):([\w+-]*)$/,
      search: (term, callback) ->
        callback(emojiAliases.filter (e) -> e.indexOf(term) != -1)
      template: (value) ->
        "<img src='/images/emoji/#{gon.emojis[value]}' class=emoji /> #{value}"
      replace: (value) ->
        "$1:#{value}:"
    ], maxCount: 5)

$(ready)
$(document).on('page:load', ready)
