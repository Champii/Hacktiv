_ = require 'underscore'
bus = require './Bus'

nextId = 1

class Computation

  id: null
  deps: []
  previous: null

  constructor: (@f) ->
    @id = nextId++
    @Record()

  Record: ->
    @StartRecord()
    @f()
    @StopRecord()

  StartRecord: ->
    return if @recorder?

    for dep in @deps
      dep.dep.removeListener 'changed', dep.handler

    @deps = []
    @recorder = (dep) =>

      handler = (dep) =>
        @Record()

      dep.on 'changed', handler
      @deps.push {dep, handler} if dep not in @deps

    bus.on 'depends', @recorder

    @previous = Hacktiv._.GetCurrent()

    Hacktiv._.SetCurrent @

  StopRecord: ->
    return if not @recorder?

    bus.removeListener 'depends', @recorder

    @recorder = null
    Hacktiv._.SetCurrent @previous

  Stop: ->
    for dep in @deps
      dep.dep.removeListener 'changed', dep.handler
      
    Hacktiv._.Remove @

module.exports = Computation
Hacktiv = require './Hacktiv'
