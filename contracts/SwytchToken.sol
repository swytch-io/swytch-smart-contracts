pragma solidity ^0.4.18;

import "./bancor/SmartToken.sol";


contract SwytchToken is SmartToken {
    event Mint(address indexed to, uint256 amount);
    event MintFinished();

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

    //
    bool public mintingFinished = false;


    modifier canMint() {
        require(!mintingFinished);
        _;
    }

    /**
     * @dev Function to mint tokens
     * @param _to The address that will receive the minted tokens.
     * @param _amount The amount of tokens to mint.
     * @return A boolean that indicates if the operation was successful.
     */
    function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {
        totalSupply_ = totalSupply_.add(_amount);
        balances[_to] = balances[_to].add(_amount);
        Mint(_to, _amount);
        Transfer(address(0), _to, _amount);
        return true;
    }

    /**
     * @dev Function to stop minting new tokens.
     * @return True if the operation was successful.
     */
    function finishMinting() onlyOwner canMint public returns (bool) {
        mintingFinished = true;
        MintFinished();
        return true;
    }



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
