
class _Hacktiv

  @active: false
  @computations: []
  @current: null

  @Watch: (f) ->
    @current?.Pause()
    comp = new Computation f
    @current?.Resume()
    comp

  @Pop: ->
    comput = @computations.pop()
    @SetCurrent comput
    comput

  @AddComput: (comput) ->
    @computations.push @current if @current?
    @SetCurrent comput
    comput

  @DontWatch: (f) ->
    prev = @current
    @SetCurrent null
    f()
    @SetCurrent prev

  @SetCurrent: (comput) ->
    @current = comput
    @active = !!@current
    Hacktiv.active = @active
    # console.log 'SetCurrent', @active

  @GetCurrent: -> @current

  @Remove: (comp) ->
    @computations.splice @computations.indexOf(comp), 1


Hacktiv = (f) ->
  _Hacktiv.Watch f


Hacktiv.DontWatch = (f) ->
  _Hacktiv.DontWatch f

Hacktiv._ = _Hacktiv
Hacktiv.active = false

Dependency = require './Dependency.coffee'
Value = require './Value.coffee'

Hacktiv.Value = Value
Hacktiv.Dependency = Dependency

module.exports = Hacktiv
Hacktiv.Computation = Computation
Computation = require './Computation.coffee'
