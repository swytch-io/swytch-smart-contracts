pragma solidity ^0.4.18;

import "./SwytchToken.sol";
import "./Utils.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";


contract SmartTokenController is Ownable, Utils {
    SwytchToken public token;   // smart token
    using SafeMath for uint256;
    /**
        @dev constructor
    */
    function SmartTokenController() public {
        //    function SmartTokenController(SwytchToken _token) public validAddress(_token) {
        owner = msg.sender;
        token = new SwytchToken();
    }



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
//    function disableTokenTransfers(bool _disable) public onlyOwner returns (bool) {
//        return token.disableTransfers(_disable);
//    }

    /**
        @dev withdraws tokens held by the token and sends them to an account
        can only be called by the owner

        @param _to      account to receive the new amount
        @param _amount  amount to withdraw
    */
    function withdrawFromToken(address _to, uint256 _amount) public onlyOwner {
        assert(token.transfer(_to, _amount));
    }

    function mintToken(address _to, uint256 _amount) public onlyOwner {
        assert(token.mint(_to, _amount));
    }

    function unmintedTokens() public returns (uint256) {
        uint256 _max = token.MAXIMUM_SUPPLY();
        uint256 _currentSupply = token.totalSupply();
        uint256 minted = _max.sub(_currentSupply);
        return minted;
    }


}