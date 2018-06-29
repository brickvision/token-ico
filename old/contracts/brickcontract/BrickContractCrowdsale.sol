pragma solidity ^0.4.23;

import "zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol";
import "zeppelin-solidity/contracts/crowdsale/FinalizableCrowdsale.sol";
import "./BrickContract.sol";

contract BrickContractCrowdsale is CappedCrowdsale, RefundableCrowdsale {

    using SafeMath for uint256;


    uint256 public initialRate = 4600;
    uint256 public finalRate = 4000;

    function BrickContractCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _goal, uint256 _cap, address _wallet) public
    CappedCrowdsale(_cap)
    Crowdsale(_startTime, _endTime, getCurrentRate(), _wallet)
    RefundableCrowdsale(_goal)
    {

    }

    // Create a custom token to mint instead of the default MintableToken
    function createTokenContract() internal returns (MintableToken) {
        return new BrickContract();
    }

    // Override to indicate when the crowdsale ends and does not accept any more contributions
    // Checks endTime by default, plus cap from CappedCrowdsale
    function hasEnded() public view returns (bool) {
        return super.hasEnded();
    }

    // Override this method to have a way to add business logic to your crowdsale when buying
    // Returns weiAmount times rate by default
    function getTokenAmount(uint256 weiAmount) internal view returns(uint256) {
        return super.getTokenAmount(weiAmount);
    }

    // Override to create custom fund forwarding mechanisms
    // Forwards funds to the specified wallet by default
    function forwardFunds() internal {
        return super.forwardFunds();
    }

    // Criteria for accepting a purchase
    // Make sure to call super.validPurchase(), or all the criteria from parents will be overwritten.
    function validPurchase() internal view returns (bool) {
        return super.validPurchase();
    }

    // Override to execute any logic once the crowdsale finalizes
    // Requires a call to the public finalize method, only after the sale hasEnded
    // Remember that super.finalization() calls the token finishMinting(),
    // so no new tokens can be minted after that
    function finalization() internal {
        super.finalization();
    }

    // @dev Calculates the amount of BRICKS returned by the smart contract based on the time within the ICO
    function getCurrentRate() public view returns (uint256) {

        // Check if the timestamp is before 1 August 2018 0:00:00
        if(block.timestamp < 1533081600) {
            return initialRate;
        }

        // Return the normal rate
        return finalRate;
    }
}