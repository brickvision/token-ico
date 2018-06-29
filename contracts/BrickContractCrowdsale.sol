pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/distribution/FinalizableCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";


// interface since ERC20 token doesn't have the finishMintable function
interface MintableERC20 {
    function finishMinting() public returns (bool);
}


contract BrickContractCrowdsale is Crowdsale, TimedCrowdsale, CappedCrowdsale, MintedCrowdsale {

    bool public isFinalized = false;
    
    event Finalized();
    
    
    constructor(uint256 _rate, 
                address _wallet, 
                ERC20 _token,
                uint256 _openingTime, 
                uint256 _closingTime,
                uint256 _cap)
        Crowdsale(_rate, _wallet, _token)
        TimedCrowdsale(_openingTime, _closingTime)
        CappedCrowdsale(_cap)
        public
    {
        
        
    }

    // Instead of using finalizeable crowdsale, decided to use TimedCrowdsale only and copy over this small part
    function finalize() public {
        require(!isFinalized);
        require(hasClosed() || capReached());

        finalization();
        emit Finalized();

        isFinalized = true;
    }
    
    function finalization() internal {
        
        // calculate how many tokens we have token mint for team, bounty and companyreserve
        
        // Stop token from being mintable
        MintableERC20 mintableToken = MintableERC20(token);
        mintableToken.finishMinting();
    }
}
