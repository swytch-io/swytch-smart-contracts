const SwytchToken = artifacts.require('../contracts/SwytchToken.sol')
const utils = require('./helpers/Utils')
const web3 = require('web3')
const BigNumber = require('bignumber.js')
contract('SwytchToken', (accounts) => {
  let token
  let owner = accounts[0]

  beforeEach(async () => {
    token = await SwytchToken.new()
    // token = await SwytchToken.new(accounts[0], 100)
  })

  describe('construction', async () => {
    it('should be ownable', async () => {
      assert.equal(await token.owner(), owner)
    })

    it('should return correct name after construction', async () => {
      assert.equal(await token.name(), 'Swytch Energy Token')
    })

    it('should return correct symbol after construction', async () => {
      assert.equal(await token.symbol(), 'SET')
    })

    it('should return correct decimal points after construction', async () => {
      assert.equal(await token.decimals(), 18)
    })

    it('should be initialized as not transferable', async () => {
      assert.equal(await token.transfersEnabled(), false)
    })

    it('should throw when attempting to transfer by default', async () => {
      let token = await SwytchToken.new()
      await token.disableTransfers(true)
      assert.equal(await token.transfersEnabled(), false)

      // await token.issue(accounts[0], 1000);
      // let balance = await token.balanceOf(accounts[0]);
      // console.log(balance)
      // assert.equal(balance, 1000);

      try {
        await token.transfer(accounts[1], 100)
        // let balance = await token.balanceOf(accounts[1]);
        // console.log(balance)
        // assert.equal(balance, 2000);
        assert(false, 'didn\'t throw')
      } catch (error) {
        return utils.ensureException(error)
      }
    })

    it('should not be able to mint a token if tranfers are disbaled', async () => {
      let token = await SwytchToken.new()
      // await token.disableTransfers(true)
      assert.equal(await token.transfersEnabled(), false)
      try {
        // await token.mint(accounts[1], 3)
        await token.mint(accounts[0], 3)
      } catch (error) {
        return utils.ensureException(error)
      }
    })

    it('should be able to mint a token', async () => {
      let token = await SwytchToken.new()
      await token.disableTransfers(false)
      assert.equal(await token.transfersEnabled(), true)
      await token.mint(accounts[1], 3)
      let balance = await token.balanceOf(accounts[1])
      assert(balance, 3)
      let newSupply = await token.totalSupply()
      assert(newSupply, 3)
    })
    it('should throw when trying to mint after minting MAX reached', async () => {
      let token = await SwytchToken.new()
      await token.disableTransfers(false)
      assert.equal(await token.transfersEnabled(), true)
      let max = await token.MAXIMUM_SUPPLY() - new BigNumber(web3.utils.toWei('4'))
      console.log(max)
      await token.mint(accounts[0], max)
      console.log(await token.totalSupply().toString())
      // await token.finishMinting()
      assert(token.mintingFinished, true)
      await token.mint(accounts[0], web3.utils.toWei('5'))
      try {
      } catch (error) {
        let e = utils.ensureException(error)
        console.log(error)
        return e
      }
    })
    it('should throw when trying to mint after minting has stopped', async () => {
      let token = await SwytchToken.new()
      await token.disableTransfers(false)
      assert.equal(await token.transfersEnabled(), true)
      await token.mint(accounts[0], 3)
      await token.finishMinting()
      assert(token.mintingFinished, true)
      try {
        await token.mint(accounts[0], 3)
      } catch (error) {
        return utils.ensureException(error)
      }
    })

  })
})