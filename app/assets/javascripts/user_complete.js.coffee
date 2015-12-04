jQuery ($) ->
  $userCompletions = $('textarea.user-complete')
  if $userCompletions.length > 0
    userAliases = Object.keys(gon.users)
    # To reload target DOM every time (although with turbolinks),
    # pass 'appendTo' option explicitly
    $userCompletions.textcomplete([
      match: /(^|\s)@([\w+-]*)$/,
      search: (term, callback) ->
        callback(userAliases.filter (e) -> e.indexOf(term) != -1)
      template: (value) ->
        "<img src='#{gon.users[value]}' class=emoji /> #{value}"
      replace: (value) ->
        "$1@#{value} "
    ], maxCount: 5, appendTo: $('body'))
