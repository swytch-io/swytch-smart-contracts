pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

/*
    Test token with predefined supply
*/
contract TestERC20Token is StandardToken {
    function TestERC20Token(uint256 _supply) public {
        totalSupply_ = _supply;
        balances[msg.sender] = totalSupply_;
    }
}
