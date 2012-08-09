class Crevasse.Previewer

  DIALECT: "Gruber" # Maruku, Gruber

  options: null

  $el: null
  $previewer: null
  $offsetDeterminer: null

  height: null
  width: null

  constructor: (@$el, @options) ->

    @$el.addClass("crevasse_reset") if @options.usePreviewerReset

    @_getDimensions()

    @$previewer = $("<div class='crevasse_previewer'>")
    @$previewer.addClass(@_theme())
    @$el.append(@$previewer)

    @$offsetDeterminer = @$previewer.clone()
    @$offsetDeterminer.css
      width: @width
      height: "auto"
      position: "absolute"
      top: 0
      left: -10000

    @$el.append(@$offsetDeterminer)

    # Listen for resizes and update dimensions accordingly
    @$el.bind("crevasse.resize", @_onResize)

    return @

  renderPreview: (text, caretPosition) ->
    offset = @_determineOffset text.substr(0, caretPosition)
    @$previewer.html markdown.toHTML(text, @DIALECT)
    offset = 0 if offset < 0
    @$el.scrollTo(offset, 0)

  _theme: ->
    switch @options.previewerStyle
      when "github" then return "github_theme"
      else return @options.previewerStyle

  _determineOffset: (text) ->
    @$offsetDeterminer.html markdown.toHTML(text, @DIALECT)
    textHeight = @$offsetDeterminer.outerHeight()
    return textHeight - @height / 2

  _onResize: (event) =>
    @_getDimensions()
    @_updateOffsetDeterminerDimensions()

  _getDimensions: ->
    @width = @$el.width()
    @height = @$el.height()

  _updateOffsetDeterminerDimensions: ->
    @$offsetDeterminer.width(@width)