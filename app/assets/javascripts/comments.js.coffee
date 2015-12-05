jQuery ($) ->
  postComment = ->
    $form = $('.js-comment-form')
    $.ajax(
      type: $form[0].method
      url: $form[0].action
      data: $form.serialize()
      dataType: 'json'
      success: (data) ->
        $('.js-comment-content').val('')
        $('.js-comment-list').html(data.html)
    )

  $('.js-comment-submit').click((event) ->
    event.preventDefault()
    postComment()
  )
  $('.js-comment-content').keydown((event) ->
    postComment() if (event.metaKey || event.ctrlKey) && event.keyCode == 13
  )
