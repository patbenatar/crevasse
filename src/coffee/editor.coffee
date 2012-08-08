class Crevasse.Editor

  options: null
  $el: null
  text: null

  constructor: (@$el, @options) ->
    _.extend @, Backbone.Events

    @$el.addClass("crevasse_editor")
    @$el.addClass(@_theme())

    @$el.bind "input", @_onInput
    @$el.bind "paste", @_onPaste

    return @

  getText: ->
    @$el.val()

  getCaretPosition: ->
    @$el.caret()

  _theme: ->
    switch @options.editorStyle
      when "default" then return "default_theme"
      else return @options.editorStyle

  _onInput: (event) =>
    return if @text == @getText()
    @text = @getText()
    @trigger "change"

  _onPaste: (event) =>
    # Wait for textarea to reflect pasted data
    setTimeout (=>
      @trigger "change"
    ), 20
