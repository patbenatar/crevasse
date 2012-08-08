class Crevasse

  settings:
    previewer: null
    editorStyle: "default"
    usePreviewerReset: true
    previewerStyle: "github"

  editor: null
  previewer: null

  constructor: ($el, options = {}) ->
    @options = $.extend({}, @settings, options)

    throw "You must initialize on a textarea" unless $el.is("textarea")
    throw "You must provide a previewer element via options" unless @options.previewer

    # Get jQuery object for previewer if initialized as selector string
    if typeof @options.previewer == "string"
      @options.previewer = $(@options.previewer)

    @editor = new Crevasse.Editor($el, @options)
    @previewer = new Crevasse.Previewer(@options.previewer, @options)

    @editor.on "change", @_onEditorChange, @

    # Handle initial value in editor textarea
    @_onEditorChange() unless @editor.getText() == ""

  _onEditorChange: =>
    @previewer.renderPreview(
      @editor.getText(),
      @editor.getCaretPosition()
    )