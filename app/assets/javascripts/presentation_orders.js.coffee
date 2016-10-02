jQuery ($) ->
  $('.presentation-order-random-all').click( ->
    $(this).parents('table').find('.presentation-order-random').prop('checked', true).change()
  )
  $('.presentation-order-random-clear').click( ->
    $(this).parents('table').find('.presentation-order-random').prop('checked', false).change()
  )
  $('.presentation-order-random').change( ->
    $(this).parents('tr').find('.order-selector').prop('disabled', $(this).prop('checked'))
  )
