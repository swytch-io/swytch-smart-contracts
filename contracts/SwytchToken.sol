pragma solidity ^0.4.18;

import "./bancor/SmartToken.sol";


contract SwytchToken is SmartToken {

    //
    string public name = "Swytch Energy Token";

    //
    string public symbol = "SET";

    //
    uint8 public decimals = 18;
    // 3,650,000,000 tokens with 18 decimal places
    uint256 public INITIAL_SUPPLY = 3.65e9 * (10 ** uint256(decimals));
    //    uint256 public INITIAL_SUPPLY = 3.65e4 * (10 ** uint256(decimals));
    //    uint256 public INITIAL_SUPPLY = 1000;


    /**
     * @dev Constructor that gives msg.sender all of existing tokens.
     */
    function SwytchToken()
    public
    SmartToken(name, symbol, decimals) {
        owner = msg.sender;
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        Transfer(0x0, owner, INITIAL_SUPPLY);
        NewSmartToken(address(this));
    }

    function deposit() payable returns (bool success) {
        if (msg.value == 0) return false;
        balances[msg.sender] += msg.value;
        totalSupply_ += msg.value;
        return true;
    }

    //    function withdraw(uint256 amount) returns (bool success) {
    //        if (balances[msg.sender] < amount) return false;
    //        balances[msg.sender] -= amount;
    //        totalSupply_ -= amount;
    //        if (!msg.sender.send(amount)) {
    //            balances[msg.sender] += amount;
    //            totalSupply_ += amount;
    //            return false;
    //        }
    //        return true;
    //    }
}
