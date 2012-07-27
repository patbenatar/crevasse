$ = jQuery

$.fn.extend
  crevasse: (options) ->
    $(@).each ->
      new Crevasse($(@), options)

class Crevasse

  settings: {}

  container:
    $el: null
    width: null
    height: null

  editor: null
  previewer: null

  constructor: ($el, options = {}) ->
    @options = $.extend({}, @settings, options)

    @container.$el = $el
    @container.width = $el.width()
    @container.height = $el.height()

    @container.$el.css "overflow", "hidden"

    @editor = new Crevasse.Editor(@container.width/2, @container.height)
    @previewer = new Crevasse.Previewer(@container.width/2, @container.height)

    @editor.on "change", @_onEditorChange, @

    @_insertIntoContainer()

  _insertIntoContainer: ->
    @container.$el.append(@editor.getEl())
    @container.$el.append(@previewer.getEl())
    @container.$el.append(@previewer.getOffsetDeterminer())

  _onEditorChange: =>
    @previewer.renderPreview(
      @editor.getText(),
      @editor.getCaretPosition()
    )


class Crevasse.Editor

  PADDING: 20
  width: null
  height: null

  $el: null
  $textarea: null

  text: null

  constructor: (@width, @height) ->
    _.extend @, Backbone.Events
    @$el = $("<div class='crevasse_editor crevasse_reset'>")
    @$textarea = $("<textarea>")
    @$el.css
      width: @width
      height: @height
    @$textarea.css
      width: @width - @PADDING*2
      height: @height - @PADDING*2
      padding: @PADDING

    @$el.append(@$textarea)

    @$textarea.bind "input", @_onTextareaInput
    @$textarea.bind "paste", @_onTextareaPaste

    return @

  getEl: -> @$el

  getText: ->
    @$textarea.val()

  getCaretPosition: ->
    @$textarea.caret()

  _onTextareaInput: (event) =>
    return if @text == @getText()
    @text = @getText()
    @trigger "change"

  _onTextareaPaste: (event) =>
    # Wait for textarea to reflect pasted data
    setTimeout (=>
      console.log "here"
      @trigger "change"
    ), 20


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