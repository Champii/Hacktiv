EventEmitter = require('events').EventEmitter
bus = require './Bus.coffee'

class Dependency extends EventEmitter

  @nextId: 1

  constructor: ->
    @id = Dependency.nextId++

  _Depends: ->
    bus.emit 'depends', @

  _Changed: ->
    @emit 'changed', @

module.exports = Dependency
