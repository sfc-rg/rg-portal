jQuery ($) ->
  $('#search_keyword').keypress((e) ->
    if e.wich == 13
      submitSearch()
      e.preventDefault()
      false
  )
  $('#search_submit').click((e) ->
    submitSearch()
    e.preventDefault()
    false
  )
  submitSearch = ->
    location.href = '/search/' + $('#search_keyword').val()
