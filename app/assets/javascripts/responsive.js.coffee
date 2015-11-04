jQuery ($) ->
  $control = $('.control')
  $('.mobile-control').on 'click', ->
    $control.toggleClass('shown')
