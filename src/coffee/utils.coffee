Crevasse.utils = {}

Crevasse.utils.includes = (value) ->
  for val in @
    return true if val == value
  return false

Crevasse.utils.remove = (value) ->
  for val, i in @
    @splice(i, 1) if val == value
  return @