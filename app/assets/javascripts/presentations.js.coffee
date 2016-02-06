COMMENT_REFRESH_INTERVAL = 10000

jQuery ($) ->
  $(document).on('page:change', ->
    $('.presentations.show').each( ->
      intervalId = setInterval( ->
        $.ajax(
          url: $('.refreshable-comments').data('refresh-url')
          dataType: 'json'
          success: (data) ->
            $('.comment-list').html(data.html)
        )
      , COMMENT_REFRESH_INTERVAL)
      $(document).on('page:change', ->
        clearInterval(intervalId)
      )
    )
  )
