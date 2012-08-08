class Crevasse.Previewer

  DIALECT: "Gruber" # Maruku, Gruber

  options: {}

  $el: null
  $previewer: null
  $offsetDeterminer: null

  constructor: (@$el, @options) ->

    @$el.addClass("crevasse_reset")

    @$previewer = $("<div class='crevasse_previewer'>")
    @$previewer.addClass("github_theme") if @options.useDefaultPreviewerStyle
    @$el.append(@$previewer)

    @$offsetDeterminer = @$previewer.clone()
    @$offsetDeterminer.css
      width: @$el.width()
      height: "auto"
      position: "absolute"
      top: 0
      left: -10000

    @$el.append(@$offsetDeterminer)

    return @

  renderPreview: (text, caretPosition) ->
    offset = @_determineOffset text.substr(0, caretPosition)
    @$previewer.html markdown.toHTML(text, @DIALECT)
    offset = 0 if offset < 0
    @$el.scrollTo(offset, 0)

  _determineOffset: (text) ->
    @$offsetDeterminer.html markdown.toHTML(text, @DIALECT)
    textHeight = @$offsetDeterminer.outerHeight()
    return textHeight - @$el.height() / 2
