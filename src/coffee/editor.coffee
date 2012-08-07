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
