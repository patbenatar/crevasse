class Crevasse.Events

  bindings: {}

  bind: (name, handler) ->
    @bindings[name] = [] unless @bindings[name]?
    unless Crevasse.utils.includes(@bindings[name], handler)
      @bindings[name].push(handler)

  unbind: (name, handler) ->
    if handler?
      Crevasse.utils.remove(@bindings[name], handler) if @bindings[name]?
      delete @bindings[name] if @bindings[name].length < 1
    else
      delete @bindings[name]

  trigger: (name) ->
    handler() for handler in @bindings[name] if @bindings[name]?