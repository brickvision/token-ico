const BrickContractCrowdsale = artifacts.require('./BrickContractCrowdsale.sol');
const BrickContract = artifacts.require('./BrickContract.sol');

module.exports = function(deployer, network, accounts) {
    const openingTime = web3.eth.getBlock('latest').timestamp + 2; // two secs in the future
    const closingTime = openingTime + 86400 * 20; // 20 days
    const rate = new web3.BigNumber(1000);
    const wallet = accounts[1];

    return deployer
        .then(() => {
            return deployer.deploy(BrickContract);
        })
        .then(() => {
            return deployer.deploy(
                BrickContractCrowdsale,
                openingTime,
                closingTime,
                rate,
                wallet,
                BrickContract.address
            );
        });
};