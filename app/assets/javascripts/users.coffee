jQuery ($) ->
  $('body.users.index').each( ->
    $('select#user_role').change( ->
      $(this).closest('form').submit()
    )
  )
