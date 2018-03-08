require('babel-register')
require('babel-polyfill')

module.exports = {
  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '10', // Match any network id
    },
    coverage: {
      host: '127.0.0.1',
      network_id: '*',
      port: 8555,
    }
  },
  mocha: {
    useColors: true,
    slow: 30000,
    bail: false
  }
}