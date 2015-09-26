$ ->
  return if $('.users.index').size() == 0
  $('select#user_role').change( ->
    $(this).closest('form').submit()
  )
