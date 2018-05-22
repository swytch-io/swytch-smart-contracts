var SwytchToken = artifacts.require('./SwytchToken.sol')

module.exports = (deployer, network, accounts) => {
  deployer.deploy(SwytchToken)
}
