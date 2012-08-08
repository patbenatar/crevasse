class Crevasse.Editor

  options: {}
  $el: null
  text: null

  constructor: (@$el, @options) ->
    _.extend @, Backbone.Events

    @$el.addClass("crevasse_editor")
    @$el.addClass("default_theme") if @options.useDefaultEditorStyle

    @$el.bind "input", @_onInput
    @$el.bind "paste", @_onPaste

    return @

  getText: ->
    @$el.val()

  getCaretPosition: ->
    @$el.caret()

  _onInput: (event) =>
    return if @text == @getText()
    @text = @getText()
    @trigger "change"

  _onPaste: (event) =>
    # Wait for textarea to reflect pasted data
    setTimeout (=>
      @trigger "change"
    ), 20
