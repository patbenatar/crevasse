# Crevasse

Crevasse is a simple Markdown editor with a live preview. It's written in
CoffeeScript and available as a jQuery plugin.

## Demo

http://patbenatar.github.com/crevasse

## Features

* Edit Markdown in one pane and see the preview update live in another
* Built for custom interfaces and layouts. You specify the editor and the
previewer elements, what you see on this page is just one implementation
* Preview automatically scrolls to keep the user centered on what they are
editing
* Supports flexible dimensions as well as dynamically changing dimensions with
JavaScript
* Comes with default themes (shown here) and supports custom themes
* The raw Markdown is stored and edited in a simple textarea, making it easy to
integrate with existing forms and backends

## Installation and Usage

* Grab the latest code from the `lib/` directory
* Download all dependency libraries (see below or available in `dependencies/`)
* Create a `textarea` for the editor and any element for the previewer.

```html
<textarea id="your_editor"></textarea>
<div id="your_previewer"></div>
```

```css
#your_editor, #your_previewer {
  width: 500px;
  height: 600px;
  display: inline-block;
}
```

* Initialize Crevasse on the textarea and pass the previewer as an option

```javascript
$("#your_editor").crevasse({
  previewer: $("#your_previewer")
});
```

* Enjoy split-screen Markdown zen

## Dependencies

Crevasse depends on a number of other libraries. They are listed below or you
can find versions of each library guaranteed to work with Crevasse in the
`dependencies/` directory.

* [jquery](http://jquery.com)
* [backbone.js](http://backbonejs.org/) (and therefore [underscore.js](http://underscorejs.org/)) \*
* [jquery.caret](https://github.com/DrPheltRight/jquery-caret)
* [jquery.scrollTo](http://demos.flesler.com/jquery/scrollTo/)
* [github\_flavored\_markdown.js](http://github.com/patbenatar/github_flavored_markdown.js) \*\*

\* The only part of Backbone that Crevasse requires is Backbone.Events, I just
haven't extracted that or implemented a standalone Event Emitter like
[Wolfy87/EventEmitter](https://github.com/Wolfy87/EventEmitter/). If someone
wants to do this, that'd be appreciated.

\*\* github\_flavored\_markdown.js is a work in progress. It is a fully functional
Markdown parser, but its support for Github's \`\`\` code blocks is not yet
complete.

## Advanced usage

### Options (shown with defaults)

```javascript
{
  previewer: null, // required. jQuery object or selector string
  editorStyle: "default", // theme to use for editor
  usePreviewerReset: true, // reset CSS for previewer pane
  previewerStyle: "github" // theme to use for previewer
}
```

### Custom themes

Crevasse comes with default themes for the editor and previewer. If you'd like,
you can customize the appearance of both.

##### Editor theme

Out of the box, the editor uses the `default` theme. This is controlled via the
`editorStyle` option. If you'd like to use a custom theme, simply set `editorStyle`
to a CSS class of your own.

##### Previewer theme

Out of the box, the previewer uses the `github` theme. The rendered Markdown
will be styled the same as what you are used to seeing on GitHub. You can
customize this via the `previewerStyle` option. If you'd like to use a custom
theme, simply set `previewerStyle` to a CSS class of your own.

### Support for flexible dimensions

If at any time the dimensions of the previewer or editor change, whether with
JavaScript or a window resize, you will need to fire the `crevasse.resize` event
on the corresponding element (your editor or previewer or both).

```javascript
// Resize with window resize
$(window).resize(function () {
  $("#your_previewer").trigger("crevasse.resize");
});

// Resize manually
$("#your_previewer").width(400).trigger("crevasse.resize");
```

### Changing the value dynamically with JavaScript

If you would like to change the value of the `textarea` without user interaction,
simply fire the `change` event on the `textarea` and Crevasse will update the preview.

```javascript
$("#your_editor").val("Some new value").trigger("change");
```

## Wishlist

* Complete the github\_flavored\_markdown.js lib

## Contributing

1. Fork and clone your fork
1. Run `$ cake build:development` to automatically compile changes made in `src/` to `development/lib/`
1. Make changes to the library files in `src/`
1. Test those changes in `development/example.html`
1. Pull request!

If you'd like to build your own package for release, you can edit the version number
in `VERSION` and run `$ cake build` to version and compile to `lib/`