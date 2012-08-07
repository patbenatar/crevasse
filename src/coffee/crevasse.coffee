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
