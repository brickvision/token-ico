// Library for setting environment values on runtime, so not showing them in the code (mainly used for MNEMONIC which is similar to a passphrase)
require('dotenv').config();

// HD waller provider is a wallet creator / manager in order to sign transactions in combination with a service like Infura
// Infura is like a remote Node of Ethereum, normally we're required to run an Ethereum node in order to interact with it (deploy contracts)
// But using a public node with an API key (see below in provider: function() {..}; we're able to deploy contracts by Infura public node
// However, infura itself is not able to sign our deployments (transaction), we have to use a library like "truffle hd wallet"
var HDWalletProvider = require("truffle-hdwallet-provider");

module.exports = {
    networks: {
        // For the development network we're using the UI version of ganache
        development: {
            host: 'localhost',
            port: 7545,
            network_id: '5777'
        },
        kovan: {
            provider: function() {
                return new HDWalletProvider(process.env.MNEMONIC, "https://kovan.infura.io/lkmB3Ms3nAjM5GzK8Tes")
            },
            network_id: '42'
        }
    },
    rpc: {
        gas: 4712388
    },
    solc: {
        optimizer: {
            enabled: true,
            runs: 200
        }
    }
};
