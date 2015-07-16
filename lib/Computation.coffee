bus = require './Bus'

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

module.exports = Computation
