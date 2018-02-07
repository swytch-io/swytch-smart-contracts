pragma solidity ^0.4.18;


import "zeppelin-solidity/contracts/token/ERC20/PausableToken.sol";


// mock class using StandardToken
contract PausableTokenMock is PausableToken {

    function PausableTokenMock(address initialAccount, uint256 initialBalance) public {
        balances[initialAccount] = initialBalance;
        totalSupply_ = initialBalance;
    }

}