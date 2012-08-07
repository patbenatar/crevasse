class Crevasse.Previewer

  DIALECT: "Gruber" # Maruku, Gruber

  PADDING: 20
  width: null
  height: null

  $el: null
  $offsetDeterminer: null

  constructor: (@width, @height) ->
    @$el = $("<div class='crevasse_previewer crevasse_reset'>")
    @$el.css
      width: @width - @PADDING*2
      height: @height - @PADDING*2
      padding: @PADDING
      overflow: "scroll"

    @$offsetDeterminer = @$el.clone()
    @$offsetDeterminer.css
      height: "auto"
      position: "absolute"
      top: 0
      left: -10000

    return @

  getEl: -> @$el

  getOffsetDeterminer: -> @$offsetDeterminer

  renderPreview: (text, caretPosition) ->
    offset = @_determineOffset text.substr(0, caretPosition)
    @$el.html markdown.toHTML(text, @DIALECT)
    offset = 0 if offset < 0
    @$el.scrollTo(offset, 0)

  _determineOffset: (text) ->
    @$offsetDeterminer.html markdown.toHTML(text, @DIALECT)
    textHeight = @$offsetDeterminer.outerHeight()
    return textHeight - @height / 2
