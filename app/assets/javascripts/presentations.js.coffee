COMMENT_REFRESH_INTERVAL = 10000

jQuery ($) ->
  $('.presentations.show').each( ->
    setInterval( ->
      $.ajax(
        url: $('.refreshable-comments').data('refresh-url')
        dataType: 'json'
        success: (data) ->
          $('.comment-list').html(data.html)
      )
    , COMMENT_REFRESH_INTERVAL)
  )
