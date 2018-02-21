pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./crowdsale/Crowdsale.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "./SwytchToken.sol";


contract SwytchCrowdsale is Crowdsale, Ownable {

    // =================================================================================================================
    //                                      Constants
    // =================================================================================================================
    // Max amount of known addresses of which will get SET by 'Grant' method.
    //
    // grantees addresses will be Swytch wallets addresses.
    // these wallets will contain SET tokens that will be used for 2 purposes only -
    // 1. SET tokens against raised fiat money
    // 2. SET tokens for presale bonus.
    // we set the value to 10 (and not to 2) because we want to allow some flexibility for cases like fiat money that is raised close to the crowdsale.
    // we limit the value to 10 (and not larger) to limit the run time of the function that process the grantees array.
    uint8 public constant MAX_TOKEN_GRANTEES = 10;

    // SET to ETH base rate
    uint256 public constant EXCHANGE_RATE = 1;

    /// Total SET minted = 3,650,000,000 or 3.65e9
    uint256 public constant FIXED_TOTAL_SUPPLY = 3.65e9;

    /// Total TEG Allocation is 10% of 3,650,000,000 = 365,000,000 or 3.65e8
    uint256 public constant TGE_TOTAL_ALLOCATION = 3.65e8;

    ///  Total Sale get 55% of of 365.000,000 = 200,750,000
    uint256 public constant TOTAL_SALE_ALLOCATION = 200750000;

    /// Pre-sale  get 5% of of 365.000,000 = 18,250,000
    uint256 public constant PRIVATE_SALE_ALLOCATION = 18250000;

    /// Public Sale get 50% of of 365.000,000 = 182,500,000
    uint256 public constant CROWDSALE_ALLOCATION = (TOTAL_SALE_ALLOCATION - PRIVATE_SALE_ALLOCATION);

    /// Core Team gets 15% of 365.000,000 = 54,750,000
    uint256 public constant CORE_TEAM_ALLOCATION = 54750000;

    /// TCF gets 14% of 365.000,000 = 51,100,000
    uint256 public constant TOKEN_COMMONS_ALLOCATION = 51100000;

    /// Bounty get 10% of of 365.000,000 = 36,500,000
    uint256 public constant PARTNERSHIPS_ALLOCATION = 36500000;

    /// Future Reserves get 3% of of 365.000,000 = 10,950,000
    uint256 public constant FUTURE_RESERVE_ALLOCATION = 10950000;

    /// Bounty get 3% of of 365.000,000 = 10,950,000
    uint256 public constant BOUNTY_ALLOCATION = 10950000;

    // =================================================================================================================
    //                                      Modifiers
    // =================================================================================================================

    /**
     * @dev Throws if called not during the crowdsale time frame
     */
    modifier onlyWhileSale() {
        require(isActive());
        _;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    // =================================================================================================================
    //                                      Members
    // =================================================================================================================


    address public wallet;
    address public teamWallet; // 15% of allocations
    address public foundationWallet; // 14% of allocations
    address public partnershipWallet; // 10% of allocations
    address public bountyWallet; // 3% of allocations
    address public reserveWallet; // 3% of allocations

    // Funds collected outside the crowdsale in wei
    //Grantees - private sale and early investors
    address[] public presaleGranteesMapKeys;
    mapping(address => uint256) public presaleGranteesMap;  //address=>wei token amount

    // =================================================================================================================
    //                                      Events
    // =================================================================================================================
    event GrantAdded(address indexed _grantee, uint256 _amount);

    event GrantUpdated(address indexed _grantee, uint256 _oldAmount, uint256 _newAmount);

    event GrantDeleted(address indexed _grantee, uint256 _hadAmount);

    // =================================================================================================================
    //                                      Constructors
    // =================================================================================================================

    function SwytchCrowdsale(
        uint256 _startTime,
        uint256 _endTime,
        address _wallet,
        address _teamWallet,
        address _foundationWallet,
        address _bountyWallet,
        address _reserveWallet,
        address _partnershipWallet,
        SwytchToken _swytchToken)
    public
    Crowdsale(_startTime, _endTime, EXCHANGE_RATE, _wallet) {
        require(_wallet != address(0));
        require(_teamWallet != address(0));
        require(_foundationWallet != address(0));
        require(_bountyWallet != address(0));
        require(_reserveWallet != address(0));
        require(_partnershipWallet != address(0));
        require(_swytchToken != address(0));

        wallet = _wallet;
        teamWallet = _teamWallet;
        foundationWallet = _foundationWallet;
        bountyWallet = _bountyWallet;
        reserveWallet = _reserveWallet;
        partnershipWallet = _partnershipWallet;

        token = _swytchToken;
        owner = msg.sender;
    }

    // =================================================================================================================
    //                                      Impl Crowdsale
    // =================================================================================================================

    // @return the rate in SET per 1 ETH according to the time of the tx and the SET pricing program.
    // @Override
    function getRate() public view returns (uint256) {
        return rate;
    }

    // =================================================================================================================
    //                                      Impl FinalizableCrowdsale
    // =================================================================================================================

    // this needs work still
    function finalization() internal onlyOwner {

        // granting bonuses for the pre crowdsale grantees:
        for (uint256 i = 0; i < presaleGranteesMapKeys.length; i++) {
            var _grantee = presaleGranteesMapKeys[i];
            var _allocation = presaleGranteesMap[presaleGranteesMapKeys[i]];
            SwytchToken(token).transfer(_grantee, _allocation);
        }


        // 15% of the total number of SET tokens will be allocated to the team
        var _teamAllocation = CORE_TEAM_ALLOCATION;
        SwytchToken(token).transfer(teamWallet, _teamAllocation);

        // 14% of the total number of SET tokens will be allocated the TCF foundation,
        var _tcfAllocation = TOKEN_COMMONS_ALLOCATION;
        SwytchToken(token).transfer(foundationWallet, _tcfAllocation);

        var _bountyAllocation = BOUNTY_ALLOCATION;
        // 3% of the total number of SET tokens will be allocated to professional fees and Bounties
        SwytchToken(token).transfer(bountyWallet, _bountyAllocation);

        // 35% of the total number of SET tokens will be allocated to SWYTCH,
        // and as a reserve for the company to be used for future strategic plans for the created ecosystem
        var _reserveAllocation = FUTURE_RESERVE_ALLOCATION;
        SwytchToken(token).transfer(reserveWallet, _reserveAllocation);

        // Re-enable transfers after the token sale.
        SwytchToken(token).disableTransfers(false);

        // Keep destroy function disabled after the token sale.
        SwytchToken(token).setDestroyEnabled(false);

        // transfer token ownership to crowdsale owner
        SwytchToken(token).transferOwnership(owner);
    }

    // =================================================================================================================
    //                                      Public Methods
    // =================================================================================================================
    // @return the total funds collected in wei(ETH and none ETH).
    function getTotalFundsRaised() public view returns (uint256) {
        return 0x0;
    }

    // @return true if the crowdsale is active, hence users can buy tokens
    function isActive() public view returns (bool) {
        return now >= startTime && now < endTime;
    }

    // =================================================================================================================
    //                                      External Methods
    // =================================================================================================================
    // @dev Adds/Updates address and token allocation for token grants.
    // Granted tokens are allocated to non-ether, presale, buyers.
    // @param _grantee address The address of the token grantee.
    // @param _value uint256 The value of the grant in wei token.
    function addUpdateGrantee(address _grantee, uint256 _value) external onlyOwner onlyWhileSale {
        require(_grantee != address(0));
        require(_value > 0);

        // Adding new key if not present:
        if (presaleGranteesMap[_grantee] == 0) {
            require(presaleGranteesMapKeys.length < MAX_TOKEN_GRANTEES);
            presaleGranteesMapKeys.push(_grantee);
            GrantAdded(_grantee, _value);
        }
        else {
            GrantUpdated(_grantee, presaleGranteesMap[_grantee], _value);
        }

        presaleGranteesMap[_grantee] = _value;
    }

    // @dev deletes entries from the grants list.
    // @param _grantee address The address of the token grantee.
    function deleteGrantee(address _grantee) external onlyOwner onlyWhileSale {
        require(_grantee != address(0));
        require(presaleGranteesMap[_grantee] != 0);

        //delete from the map:
        delete presaleGranteesMap[_grantee];

        //delete from the array (keys):
        uint256 index;
        for (uint256 i = 0; i < presaleGranteesMapKeys.length; i++) {
            if (presaleGranteesMapKeys[i] == _grantee) {
                index = i;
                break;
            }
        }
        presaleGranteesMapKeys[index] = presaleGranteesMapKeys[presaleGranteesMapKeys.length - 1];
        delete presaleGranteesMapKeys[presaleGranteesMapKeys.length - 1];
        presaleGranteesMapKeys.length--;

        GrantDeleted(_grantee, presaleGranteesMap[_grantee]);
    }

}
