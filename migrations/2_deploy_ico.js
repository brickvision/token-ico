var BrickContract = artifacts.require("./BrickContract.sol");
var BrickContractCrowdsale = artifacts.require("./BrickContractCrowdsale.sol");

const duration = {
    seconds: function (val) { return val; },
    minutes: function (val) { return val * this.seconds(60); },
    hours: function (val) { return val * this.minutes(60); },
    days: function (val) { return val * this.hours(24); },
    weeks: function (val) { return val * this.days(7); },
    years: function (val) { return val * this.days(365); },
};

module.exports = async function(deployer, network, accounts) {
    
    // Deploy the BrickContract contract which creates the Token (BRICKS)
    await deployer.deploy(BrickContract, "BrickContract by BrickVision", "BRICKS", 18);
    
    // Get a reference to the deployed token contract
    const deployedToken = await BrickContract.deployed();
    
    // Log the deployed token
    console.log("deployed token address: ", deployedToken.address);
    
    // Variables for the CrowdSale
    const rate = 4000; // 1 ETH = 4000 BRICKS tokens
    const wallet = accounts[0]; // For now the funds will go to the wallet of the deployer (account[0])
    const timeNow = Math.floor(Date.now() / 1000); // Get the current time
    const openingTime = timeNow + duration.seconds(30); // ICO starts in 30 seconds after deployment of the contract
    const closingTime = openingTime + duration.days(60); // ICO runs for 60 days
    const cap = web3.toWei(100); // Cap of crowdsale is 100 ETH

    await deployer.deploy(BrickContractCrowdsale, 
        rate, wallet, deployedToken.address, openingTime, closingTime, cap
    );

    // Get the reference of the deployed crowdsale contract
    var deployedCrowdsale = await BrickContractCrowdsale.deployed();
    
    console.log("Crowdsale address: ", deployedCrowdsale.address);
    
    // In this setup we've the token created first, it's easier to let the crowdsale contract create the token
    // since it will be the owner in that case and we don't have to transfer ownership, however this structure we create token in other contract
    // so transfer ownership so the crowdsale is allowed to mint tokens (create token)
    await deployedToken.transferOwnership(deployedCrowdsale.address);
    
    // Log the addresses of both contracts deployed
    console.log("Contracts deployed \n", deployedToken, deployedCrowdsale);

};
