Crevasse.utils = {}

Crevasse.utils.includes = (array, value) ->
  for val in array
    return true if val == value
  return false

Crevasse.utils.remove = (array, value) ->
  for val, i in array
    array.splice(i, 1) if val == value
  return