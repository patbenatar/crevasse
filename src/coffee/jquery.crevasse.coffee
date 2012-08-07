$ = jQuery

$.fn.extend
  crevasse: (options) ->
    $(@).each ->
      new Crevasse($(@), options)
