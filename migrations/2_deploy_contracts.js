var SwytchToken = artifacts.require('./SwytchToken.sol')
// var SmartTokenController = artifacts.require('./SmartTokenController.sol')
// var SwytchCrowdsale = artifacts.require('./SwytchCrowdsale.sol')

module.exports = (deployer, network, accounts) => {
  console.log(network)
  //
  // if (network === 'ropsten') {
  //   deployer.deploy(SwytchToken, {from: '0xe3ec0033d4d5359f0ba497b0f4053d3e496b3d07'})
  // } else if (network === 'live') {
  //   throw new Error()
  //   deployer.deploy(SwytchToken, {from: '0xe3ec0033d4d5359f0ba497b0f4053d3e496b3d07'})
  // } else {
  // }
  deployer.deploy(SwytchToken)
  // deployer.deploy(SwytchToken).then(() => {
  //   return deployer.deploy(SmartTokenController, SwytchToken.address)
  // })
  // const MIN = 60
  // const HOUR = 60 * MIN
  // const DAY = 24 * HOUR
  //
  // TODO: CHANGE ADDRESS BEFORE PUBLISH!
  //
  // const WALLET_ADDRESS = accounts[0]
  // console.log(WALLET_ADDRESS);
  // const TEAM_ADDRESS = accounts[1]
  // console.log(TEAM_ADDRESS);
  // const TCF_WALLET_ADDRESS = accounts[2]
  // console.log(TCF_WALLET_ADDRESS);
  // const BOUNTIES_ADDRESS = accounts[3]
  // console.log(BOUNTIES_ADDRESS);
  // const RESERVE_ADDRESS = accounts[4]
  // console.log(RESERVE_ADDRESS);
  // const PARTNERS_ADDRESS = accounts[5]
  // console.log(PARTNERS_ADDRESS);
  //
  // const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 60 * 2;
  // const startTime = web3.eth.getBlock('latest').timestamp
  // const endTime = startTime + DAY * 14
  // const rate = new web3.BigNumber(1000)

  // deployer.deploy(SwytchCrowdsale,
  //   startTime,
  //   endTime,
  //   WALLET_ADDRESS,
  //   TEAM_ADDRESS,
  //   TCF_WALLET_ADDRESS,
  //   BOUNTIES_ADDRESS,
  //   RESERVE_ADDRESS,
  //   PARTNERS_ADDRESS,
  //   SwytchToken)
}