require('babel-register')
require('babel-polyfill')

module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '10', // Match any network id
    },
    coverage: {
      host: 'localhost',
      network_id: '*',
      port: 8555,
    }
  },
  mocha: {
    useColors: true,
    slow: 30000,
    bail: true
  }
}