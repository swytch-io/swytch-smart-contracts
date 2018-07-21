require('babel-register')
require('babel-polyfill')

module.exports = {
  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*' // Match any network id
    },
    ropsten: {
      from: '0x9bd2B073BA79e57deCffb8EBdA9814b096Db2BB8',
      host: '127.0.0.1',
      port: 8545,
      network_id: 3,
      gas: 4700000,
      gasPrice: 1000000000
    },
    live: {
      from: '0x0b8d384010754732d16f45a7a3a427415651f3fc',
      host: '127.0.0.1',
      port: 8545,
      network_id: 1,
      gas: 4700000,
      gasPrice: 10000000000
    },
    coverage: {
      host: '127.0.0.1',
      network_id: '*',
      port: 8555
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },
  mocha: {
    useColors: true,
    slow: 30000,
    bail: false
  }
}