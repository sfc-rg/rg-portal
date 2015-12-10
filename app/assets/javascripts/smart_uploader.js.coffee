jQuery ($) ->
  $.event.props.push('dataTransfer')

  $('.js-smart-uploader').each ->
    generatePlaceholder = (file) ->
      "{Uploading... #{file.name} #{file.lastModified}} "

    $this = $(this)
    $this.bind('dragover', (e) ->
      $this.addClass('dragover')
      e.stopPropagation()
      e.preventDefault()
    )
    $this.bind('dragleave', (e) ->
      $this.removeClass('dragover')
      e.stopPropagation()
      e.preventDefault()
    )
    $this.bind('drop', (e) =>
      $this.removeClass('dragover')
      e.stopPropagation()
      e.preventDefault()
      files = e.target?.files || e.dataTransfer?.files
      return unless files?

      for file in files
        currentPos = this.selectionStart
        placeholder = generatePlaceholder(file)
        content = $this.val()
        $this.val(content.substr(0, currentPos) + placeholder + content.substr(currentPos))
        this.setSelectionRange(currentPos + placeholder.length, currentPos + placeholder.length)

      async.each(files, (file, callback) =>
        form = new FormData()
        form.append('upload[file]', file)
        $.ajax(
          url: '/uploads'
          type: 'POST'
          data: form
          processData: false
          contentType: false
          success: (data) =>
            placeholder = generatePlaceholder(file)
            currentPos = this.selectionStart
            $this.val($this.val().replace(placeholder, "<img src=\"#{data.upload.url}\"> "))
            this.setSelectionRange(currentPos + placeholder.length, currentPos + placeholder.length)
            callback(null)
          error: (err) ->
            callback(err)
        )
      , (err) ->
        console.error(err)
      )
      false
    )
