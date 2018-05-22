pragma solidity ^0.4.18;

import "./bancor/SmartToken.sol";


contract SwytchToken is SmartToken {

    /**
    * @dev Contract Name
    */
    string public name = "Swytch Energy Token";

    /**
    * @dev Contract Symbol
    */
    string public symbol = "SET";

    /**
    * @dev Number of decimals
    */
    uint8 public decimals = 18;

    /**
    * @dev Initial Supply
    */
    //    uint256 public INITIAL_SUPPLY = 2.03e8 * (10 ** uint256(decimals));
    uint256 public initialSupply = 0;

    uint256 public MAXIMUM_SUPPLY = 3.65e9 * (10 ** uint256(decimals));

    /**
     * @dev Constructor that gives msg.sender all of existing tokens.
     */
    function SwytchToken()
    public
    SmartToken(name, symbol, decimals) {
        owner = msg.sender;
        totalSupply_ = initialSupply;
        balances[msg.sender] = initialSupply;
        Transfer(0x0, owner, initialSupply);
        NewSmartToken(address(this));
    }


    /** Mintable overrides */
    /**
       * @dev Override function to mint tokens
       * @param _to The address that will receive the minted tokens.
       * @param _amount The amount of tokens to mint.
       * @return A boolean that indicates if the operation was successful.
       */
    function mint(address _to, uint256 _amount) public transfersAllowed onlyOwner canMint returns (bool) {
        var current = totalSupply();
        assert(current.add(_amount) <= MAXIMUM_SUPPLY);
        return super.mint(_to, _amount);
    }

    function finishMinting() public onlyOwner canMint returns (bool) {
        return super.finishMinting();
    }
}
