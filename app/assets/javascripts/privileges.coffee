jQuery ($) ->
  $('body.privileges').each ->
    setPrivilegeFormValues = ($target) ->
      $option = $target.children('option:selected')
      model = $option.attr('data-model')
      action = $option.attr('data-action')
      $form = $target.closest('form')
      $form.children('[name="privilege[model]"]').val(model)
      $form.children('[name="privilege[action]"]').val(action)

    initPrivilegeSelector = ($target) ->
      $options = $target.children('option')
      $form = $target.closest('form')
      model = $form.children('[name="privilege[model]"]').val()
      action = $form.children('[name="privilege[action]"]').val()
      for option in $options
        $option = $(option)
        modelIdx = $option.text().indexOf(model)
        actionIdx = $option.text().indexOf(action)
        if modelIdx > -1 && actionIdx > -1 && actionIdx > modelIdx
          $option.prop('selected', true)
          return true
      return false

    $targetSelector = $('select#privilege')
    $targetSelector.change ->
      setPrivilegeFormValues($(this))
    setPrivilegeFormValues($targetSelector) unless initPrivilegeSelector($targetSelector)
