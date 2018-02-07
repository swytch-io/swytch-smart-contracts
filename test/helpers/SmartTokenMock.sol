pragma solidity ^0.4.18;

import "../../contracts/bancor/SmartToken.sol";

contract SmartTokenMock is SmartToken {

    function SmartTokenMock(address initialAccount, uint256 initialBalance) public {
        balances[initialAccount] = initialBalance;
        totalSupply_ = initialBalance;
    }

}