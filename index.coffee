Bus = require('events').EventEmitter
bus = new Bus

class Tracker

  @computations: []

  @Autorun: (f) ->
    @computations.push new Computation f

class Computation

  deps: []

  constructor: (@f) ->
    @StartRecord()
    @f()
    @StopRecord()

  StartRecord: ->
    return if @recorder?

    @recorder = (dep) =>
      @deps.push dep if dep not in @deps
      dep.on 'changed', (dep) =>
        @f()

    bus.on 'depends', @recorder

  StopRecord: ->
    return if not @recorder?

    bus.removeListener 'depends', @recorder

    @recorder = null

class Dependency extends Bus

  @nextId: 1

  constructor: ->
    @id = Dependency.nextId++

  Depends: ->
    bus.emit 'depends', @

  Changed: ->
    @emit 'changed', @

class Value

  constructor: (@v) ->
    @dep = new Dependency

  Get: ->
    @dep.Depends()
    if typeof(@v) is 'function'
      @v()
    else
      @v

  Set: (@v) ->
    @dep.Changed()

Tracker.Value = Value
module.exports = Tracker
