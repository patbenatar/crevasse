# Crevasse

Crevasse is a simple split-screen Markdown editor written in CoffeeScript. It's
available as a jQuery plugin.

## Demo

http://patbenatar.github.com/crevasse

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
  previewer: null, // required
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

Crevasse fully supports changing the dimensions of the editor or previewer at
any time.

##### Percentage dimensions and window resize

This comes out of the box. Crevasse listens for window resize events and updates
itself accordingly.

##### Resizing the elements dynamically with JavaScript

If you would like to resize the elements with JavaScript, you will need to fire
the `resize` event on the element you are resizing, whether that is the editor
or the previewer or both.

```javascript
$("#your_previewer").trigger("resize")
```

## Wishlist

Some ideas planned for the future...

* Complete the github\_flavored\_markdown.js lib

## Contributing

1. Fork and clone your fork
1. Run `$ cake build:development` to automatically compile changes made in `src/` to `development/lib/`
1. Make changes to the library files in `src/`
1. Test those changes in `development/example.html`
1. Pull request!

If you'd like to build your own package for release, you can edit the version number
in `VERSION` and run `$ cake build` to version and compile to `lib/`