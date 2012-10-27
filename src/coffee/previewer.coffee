class Crevasse.Previewer

  LANG_MAP:
    'js': 'javascript'
    'json': 'javascript'

  options: null

  $el: null
  $previewer: null
  $offsetDeterminer: null

  width: null
  height: null

  constructor: (@$el, @options) ->

    @$el.addClass("crevasse_reset") if @options.usePreviewerReset

    @_getDimensions()

    @$previewer = $("<div class='crevasse_previewer'>")
    @$previewer.addClass(@_theme())
    @$el.append(@$previewer)

    # Create a clone off-screen, without a fix height, to use for determining
    # the offset to scroll the previewer pane to
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

    marked.setOptions
      gfm: true
      pedantic: false
      sanitize: true
      highlight: (code, lang) =>
        lang = if @LANG_MAP[lang]? then @LANG_MAP[lang] else lang
        processed_code = null
        if Rainbow?
          Rainbow.color code, lang, (highlighted_code) =>
            processed_code = highlighted_code
        return processed_code || code

    return @

  render: (text, caretPosition = null) ->
    @$previewer.html @_parse(text)

    # Stop's Rainbow.js from double-highlighting
    @$previewer.find("code").addClass("rainbow") if Rainbow?

    if caretPosition?
      offset = @_determineOffset text.substr(0, caretPosition)
      offset = 0 if offset < 0
      try
        @$el.scrollTo(offset, 0)
      catch error
        # @$el is not scrollable

  _theme: ->
    switch @options.previewerStyle
      when "github" then return "github_theme"
      else return @options.previewerStyle

  _determineOffset: (text) ->
    @$offsetDeterminer.html @_parse(text)
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

  _parse: (text) ->
    marked(text)
