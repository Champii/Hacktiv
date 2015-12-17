// if require.resolve?
if (require.resolve)
  require('coffee-script').register()
Hacktiv = require('./lib/Hacktiv.coffee')

module.exports = Hacktiv
