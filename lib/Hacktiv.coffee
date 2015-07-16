Computation = require './Computation'
Dependency = require './Dependency'
Value = require './Value'

computations = []

Hacktiv = (f) ->
  computations.push new Computation f

Hacktiv.Value = Value

Hacktiv.Dependency = Dependency

module.exports = Hacktiv
