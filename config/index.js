'use strict'

let path = require('path')
let _ = require('lodash')
let url = require('url')

// All configurations will extend these options
// ============================================
let all = {
  env: process.env.NODE_ENV,
  root: path.normalize(__dirname + '/../../..'),
  host: process.env.NODE_HOST || 'localhost',
  port: parseInt(process.env.PORT) || 3000
}

// Export the config object based on the NODE_ENV
// ==============================================
module.exports = _.merge(all, require('./' + process.env.NODE_ENV + '.js') || {})
