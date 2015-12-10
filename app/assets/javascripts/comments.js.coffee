jQuery ($) ->
  postComment = ->
    $form = $('.js-comment-form')
    $submit = $('.js-comment-submit')

    return if $submit.prop('disabled')
    $submit.prop('disabled', true)

    $.ajax(
      type: $form[0].method
      url: $form[0].action
      data: $form.serialize()
      dataType: 'json'
      success: (data) ->
        $submit.prop('disabled', false)
        $('.js-comment-content').val('')
        $('.js-comment-list').html(data.html)
      error: ->
        $submit.prop('disabled', false)
    )

  $('.js-comment-submit').click((event) ->
    event.preventDefault()
    postComment()
  )
  $('.js-comment-content').keydown((event) ->
    postComment() if (event.metaKey || event.ctrlKey) && event.keyCode == 13
  )
