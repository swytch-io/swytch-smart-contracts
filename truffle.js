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
    // live: {
    //   from: '0xabc09e2ac2c45387c6fbefb882ce21a6fbeb5667',
    //   host: '127.0.0.1',
    //   port: 8545,
    //   network_id: 1,
    //   // gas: 5534126,
    //   // gasPrice: 11000000000
    // },
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