function ether (n) {
  console.log(n)
  console.log(web3)
  return new web3.BigNumber(web3.toWei(n, 'ether'))
}

module.exports = ether