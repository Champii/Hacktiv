
class _Hacktiv

  @active: false
  @computations: []
  @current: null

  @Watch: (f) ->
    comp = new Computation f
    @computations.push comp
    comp

  @DontWatch: (f) ->
    prev = @current
    @SetCurrent null
    f()
    @SetCurrent prev

  @SetCurrent: (comput) ->
    @current = comput
    @active = !!@current
    Hacktiv.active = @active

  @GetCurrent: -> @current

  @Remove: (comp) ->
    @computations.splice @computations.indexOf(comp), 1


Hacktiv = (f) ->
  _Hacktiv.Watch f
Hacktiv.DontWatch = (f) ->
  _Hacktiv.DontWatch f

Hacktiv._ = _Hacktiv
Hacktiv.active = false

Dependency = require './Dependency'
Value = require './Value'

Hacktiv.Value = Value
Hacktiv.Dependency = Dependency

module.exports = Hacktiv
Hacktiv.Computation = Computation
Computation = require './Computation'
