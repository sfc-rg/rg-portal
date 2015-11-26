jQuery ($) ->
  return if $('.presentations.show').size() == 0

  setInterval( ->
    $.ajax(
      url: $('.refreshable-comments').data('refresh-url')
      dataType: 'json'
      success: (data) ->
        $('.comment-list').html(data.html)
    )
  , 10000)
