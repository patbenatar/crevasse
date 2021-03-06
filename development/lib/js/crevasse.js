// Generated by CoffeeScript 1.3.3
(function() {
  var $, Crevasse,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  $ = jQuery;

  $.fn.extend({
    crevasse: function(options) {
      return $(this).each(function() {
        return new Crevasse($(this), options);
      });
    }
  });

  Crevasse = (function() {

    Crevasse.prototype.settings = {
      previewer: null,
      editorStyle: "default",
      usePreviewerReset: true,
      previewerStyle: "github",
      convertTabsToSpaces: 2
    };

    Crevasse.prototype.editor = null;

    Crevasse.prototype.previewer = null;

    function Crevasse($el, options) {
      if (options == null) {
        options = {};
      }
      this._onEditorChange = __bind(this._onEditorChange, this);

      this.options = $.extend({}, this.settings, options);
      if (!$el.is("textarea")) {
        throw "You must initialize on a textarea";
      }
      if (!this.options.previewer) {
        throw "You must provide a previewer element via options";
      }
      if (typeof this.options.previewer === "string") {
        this.options.previewer = $(this.options.previewer);
      }
      this.editor = new Crevasse.Editor($el, this.options);
      this.previewer = new Crevasse.Previewer(this.options.previewer, this.options);
      this.editor.bind("change", this._onEditorChange);
      if (this.editor.getText() !== "") {
        this._updatePreview();
      }
    }

    Crevasse.prototype._onEditorChange = function() {
      return this._updatePreview();
    };

    Crevasse.prototype._updatePreview = function() {
      return this.previewer.render(this.editor.getText(), this.editor.getCaretPosition());
    };

    return Crevasse;

  })();

  Crevasse.Events = (function() {

    function Events() {}

    Events.prototype.bindings = {};

    Events.prototype.bind = function(name, handler) {
      if (this.bindings[name] == null) {
        this.bindings[name] = [];
      }
      if (!Crevasse.utils.includes(this.bindings[name], handler)) {
        return this.bindings[name].push(handler);
      }
    };

    Events.prototype.unbind = function(name, handler) {
      if (handler != null) {
        if (this.bindings[name] != null) {
          Crevasse.utils.remove(this.bindings[name], handler);
        }
        if (this.bindings[name].length < 1) {
          return delete this.bindings[name];
        }
      } else {
        return delete this.bindings[name];
      }
    };

    Events.prototype.trigger = function(name) {
      var handler, _i, _len, _ref, _results;
      if (this.bindings[name] != null) {
        _ref = this.bindings[name];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          handler = _ref[_i];
          _results.push(handler());
        }
        return _results;
      }
    };

    return Events;

  })();

  Crevasse.Editor = (function(_super) {

    __extends(Editor, _super);

    Editor.prototype.options = null;

    Editor.prototype.$el = null;

    Editor.prototype.text = null;

    Editor.prototype.spaces = null;

    function Editor($el, options) {
      this.$el = $el;
      this.options = options;
      this._parseTabsToSpaces = __bind(this._parseTabsToSpaces, this);

      this._replaceTabs = __bind(this._replaceTabs, this);

      this._onPaste = __bind(this._onPaste, this);

      this._onInput = __bind(this._onInput, this);

      this.$el.addClass("crevasse_editor");
      this.$el.addClass(this._theme());
      if (this.options.convertTabsToSpaces) {
        this._replaceTabs(this.options.convertTabsToSpaces);
      }
      this.$el.bind("" + (this._inputEventName()) + " change", this._onInput);
      this.$el.bind("paste", this._onPaste);
      return this;
    }

    Editor.prototype.getText = function() {
      return this.$el.val();
    };

    Editor.prototype.getCaretPosition = function() {
      return this.$el.caret();
    };

    Editor.prototype._theme = function() {
      switch (this.options.editorStyle) {
        case "default":
          return "default_theme";
        default:
          return this.options.editorStyle;
      }
    };

    Editor.prototype._onInput = function(event) {
      if (this.text === this.getText()) {
        return;
      }
      this.text = this.getText();
      return this.trigger("change");
    };

    Editor.prototype._onPaste = function(event) {
      var _this = this;
      return setTimeout((function() {
        return _this.trigger("change");
      }), 20);
    };

    Editor.prototype._replaceTabs = function(numSpaces) {
      this.spaces = "";
      while (numSpaces--) {
        this.spaces += " ";
      }
      return this.$el.bind("keydown", this._parseTabsToSpaces);
    };

    Editor.prototype._parseTabsToSpaces = function(event) {
      if (event.keyCode === 9) {
        event.preventDefault();
        return this.$el.insertAtCaret(this.spaces);
      }
    };

    Editor.prototype._inputEventName = function() {
      if (this._supportsInputEvent()) {
        return "input";
      }
      return "keydown";
    };

    Editor.prototype._supportsInputEvent = function() {
      var el, eventName, isSupported;
      el = document.createElement('textarea');
      eventName = "oninput";
      isSupported = (__indexOf.call(el, eventName) >= 0);
      if (!isSupported) {
        el.setAttribute(eventName, 'return;');
        isSupported = typeof el[eventName] === 'function';
      }
      el = null;
      return isSupported;
    };

    return Editor;

  })(Crevasse.Events);

  Crevasse.Previewer = (function() {

    Previewer.prototype.LANG_MAP = {
      'js': 'javascript',
      'json': 'javascript'
    };

    Previewer.prototype.options = null;

    Previewer.prototype.$el = null;

    Previewer.prototype.$previewer = null;

    Previewer.prototype.$offsetDeterminer = null;

    Previewer.prototype.width = null;

    Previewer.prototype.height = null;

    function Previewer($el, options) {
      var _this = this;
      this.$el = $el;
      this.options = options;
      this._onResize = __bind(this._onResize, this);

      if (this.options.usePreviewerReset) {
        this.$el.addClass("crevasse_reset");
      }
      this._getDimensions();
      this.$previewer = $("<div class='crevasse_previewer'>");
      this.$previewer.addClass(this._theme());
      this.$el.append(this.$previewer);
      this.$offsetDeterminer = this.$previewer.clone();
      this.$offsetDeterminer.css({
        width: this.width,
        height: "auto",
        position: "absolute",
        top: 0,
        left: -10000
      });
      this.$el.append(this.$offsetDeterminer);
      this.$el.bind("crevasse.resize", this._onResize);
      marked.setOptions({
        gfm: true,
        pedantic: false,
        sanitize: true,
        highlight: function(code, lang) {
          var processed_code;
          lang = _this.LANG_MAP[lang] != null ? _this.LANG_MAP[lang] : lang;
          processed_code = null;
          if (typeof Rainbow !== "undefined" && Rainbow !== null) {
            Rainbow.color(code, lang, function(highlighted_code) {
              return processed_code = highlighted_code;
            });
          }
          return processed_code || code;
        }
      });
      return this;
    }

    Previewer.prototype.render = function(text, caretPosition) {
      var offset;
      if (caretPosition == null) {
        caretPosition = null;
      }
      this.$previewer.html(this._parse(text));
      if (typeof Rainbow !== "undefined" && Rainbow !== null) {
        this.$previewer.find("code").addClass("rainbow");
      }
      if (caretPosition != null) {
        offset = this._determineOffset(text.substr(0, caretPosition));
        if (offset < 0) {
          offset = 0;
        }
        try {
          return this.$el.scrollTo(offset, 0);
        } catch (error) {

        }
      }
    };

    Previewer.prototype._theme = function() {
      switch (this.options.previewerStyle) {
        case "github":
          return "github_theme";
        default:
          return this.options.previewerStyle;
      }
    };

    Previewer.prototype._determineOffset = function(text) {
      var textHeight;
      this.$offsetDeterminer.html(this._parse(text));
      textHeight = this.$offsetDeterminer.outerHeight();
      return textHeight - this.height / 2;
    };

    Previewer.prototype._onResize = function(event) {
      this._getDimensions();
      return this._updateOffsetDeterminerDimensions();
    };

    Previewer.prototype._getDimensions = function() {
      this.width = this.$el.width();
      return this.height = this.$el.height();
    };

    Previewer.prototype._updateOffsetDeterminerDimensions = function() {
      return this.$offsetDeterminer.width(this.width);
    };

    Previewer.prototype._parse = function(text) {
      return marked(text);
    };

    return Previewer;

  })();

  Crevasse.utils = {};

  Crevasse.utils.includes = function(array, value) {
    var val, _i, _len;
    for (_i = 0, _len = array.length; _i < _len; _i++) {
      val = array[_i];
      if (val === value) {
        return true;
      }
    }
    return false;
  };

  Crevasse.utils.remove = function(array, value) {
    var i, val, _i, _len;
    for (i = _i = 0, _len = array.length; _i < _len; i = ++_i) {
      val = array[i];
      if (val === value) {
        array.splice(i, 1);
      }
    }
  };

}).call(this);
