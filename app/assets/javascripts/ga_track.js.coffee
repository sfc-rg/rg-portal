jQuery ($) ->
  $('a.ga-track').click( ->
    $this = $(this)
    ga('send', {
      hitType: 'event',
      eventCategory: $this.data('category'),
      eventAction: $this.data('action'),
      eventLabel: $this.data('label'),
      transport: 'beacon'
    });
  )
