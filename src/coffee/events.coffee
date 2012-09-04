class Crevasse.Events

  bindings: {}

  bind: (name, handler) ->
    @bindings[name] = [] unless @bindings[name]?
    @bindings[name].push(handler) unless @bindings[name].includes(handler)

  unbind: (name, handler) ->
    @bindings[name].remove(handler) if @bindings[name]?

  trigger: (name) ->
    handler() for handler in @bindings[name] if @bindings[name]?