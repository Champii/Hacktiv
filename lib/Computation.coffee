_ = require 'underscore'
bus = require './Bus.coffee'

nextId = 1

class Computation

  id: null
  deps: []

  constructor: (@f) ->
    @id = nextId++
    @Record()

  Record: ->
    if !Hacktiv._.replay
      @StartRecord()
    @f()
    if !Hacktiv._.replay
      @StopRecord()

  StartRecord: ->
    return if @recorder?

    Hacktiv._.AddComput @

    for dep in @deps
      dep.dep.removeListener 'changed', dep.handler

    @deps = []
    @recorder = (dep) =>

      handler = (dep) =>
        Hacktiv._.replay = true
        @f()
        Hacktiv._.replay = false

      dep.on 'changed', handler
      @deps.push {dep, handler} if dep not in @deps

    bus.on 'depends', @recorder

  Pause: ->
    return if not @recorder?

    bus.removeListener 'depends', @recorder

  Resume: ->
    return if not @recorder?

    bus.on 'depends', @recorder

  StopRecord: ->
    return if not @recorder?

    bus.removeListener 'depends', @recorder

    @recorder = null
    Hacktiv._.Pop()

  Stop: ->
    for dep in @deps
      dep.dep.removeListener 'changed', dep.handler

    Hacktiv._.Remove @

module.exports = Computation
Hacktiv = require './Hacktiv.coffee'
