pragma solidity ^0.4.18;

import "./bancor/SmartToken.sol";
import "./Utils.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";


contract SmartTokenController is Ownable, Utils {
    SmartToken public token;   // smart token

    /**
        @dev constructor
    */
    function SmartTokenController(SmartToken _token) public validAddress(_token) {
        owner = msg.sender;
        token = _token;
    }

    // ensures that the controller is the token's owner
    //    modifier active() {
    //        assert(token.owner() == address(this));
    //        _;
    //    }

    // ensures that the controller is not the token's owner
    //    modifier inactive() {
    //        assert(token.owner() != address(this));
    //        _;
    //    }

    /**
        @dev allows transferring the token ownership
        the new owner still need to accept the transfer
        can only be called by the contract owner

        @param _newOwner    new token owner
    */
    function transferTokenOwnership(address _newOwner) public {
        token.transferOwnership(_newOwner);
    }

    /**
        @dev disables/enables token transfers
        can only be called by the contract owner

        @param _disable    true to disable transfers, false to enable them
    */
    function disableTokenTransfers(bool _disable) public {
        token.disableTransfers(_disable);
    }

    /**
        @dev withdraws tokens held by the token and sends them to an account
        can only be called by the owner

        @param _to      account to receive the new amount
        @param _amount  amount to withdraw
    */
    function withdrawFromToken(address _to, uint256 _amount) public {
        assert(token.transfer(_to, _amount));
    }
}