Dependency = require './Dependency'

Value = (value) ->

  do ->
    dep = new Dependency
    v = value

    get = ->
      if typeof(v) is 'function'
        v()
      else
        v

    (newV) ->
      if not newV?
        dep._Depends()
        get()
      else
        v = newV
        dep._Changed()
        v

module.exports = Value
