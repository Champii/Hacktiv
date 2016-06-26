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

    (newV, hactive = true) ->
      if not newV?
        dep._Depends() if hactive
        get()
      else
        v := newV
        dep._Changed() if hactive
        v


module.exports = Value
