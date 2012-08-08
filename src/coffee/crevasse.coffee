class Crevasse

  settings:
    previewer: null
    useDefaultEditorStyle: true
    useDefaultPreviewerStyle: true

  editor: null
  previewer: null

  constructor: ($el, options = {}) ->
    @options = $.extend({}, @settings, options)

    throw "You must initialize on a textarea" unless $el.is("textarea")
    throw "You must provide a previewer element via options" unless @options.previewer

    @editor = new Crevasse.Editor($el, @options)
    @previewer = new Crevasse.Previewer(@options.previewer, @options)

    @editor.on "change", @_onEditorChange, @

  _onEditorChange: =>
    @previewer.renderPreview(
      @editor.getText(),
      @editor.getCaretPosition()
    )