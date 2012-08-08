# Crevasse

Crevasse is a simple split-screen Markdown editor written in CoffeeScript. It's
available as a jQuery plugin.

## Installation and Usage

1. Grab the latest code from the `lib/` directory
1. Download all dependency libraries (see below or available in `dependencies/`)
1. Create an HTML element with a width and height (no support for flexible
dimensions yet)

```html
<div id="crevasse_container"></div>
```

```css
#crevasse_container {
  width: 1000px;
  height: 600px;
}
```

1. Initialize Crevasse on that container

```javascript
$("#crevasse_container").crevasse();
```
1. Enjoy split-screen Markdown zen

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

## Wishlist

Some ideas planned for the future...

* Support for flexible dimensions on the container element
* Complete the github\_flavored\_markdown.js lib