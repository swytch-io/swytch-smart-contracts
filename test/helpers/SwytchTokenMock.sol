pragma solidity ^0.4.18;

import "../../contracts/bancor/SmartToken.sol";


contract SwytchTokenMock is SmartToken {

    string public name = "Swytch Energy Token";
    string public symbol = "SET";
    uint8 public decimals = 18;
    // 3,650,000,000 tokens with 18 decimal places
    //    uint256 public INITIAL_SUPPLY = 3.65e9 * (10 ** uint256(decimals));
    //    uint256 public INITIAL_SUPPLY = 3.65e4 * (10 ** uint256(decimals));
    //    uint256 public INITIAL_SUPPLY = 1000;

    function SwytchTokenMock(address initialAccount, uint256 initialBalance)
    public
    SmartToken(name, symbol, decimals)
    {
        balances[initialAccount] = initialBalance;
        totalSupply_ = initialBalance;
    }
}
