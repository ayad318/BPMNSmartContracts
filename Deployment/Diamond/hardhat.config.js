/* global ethers task */
require("@nomiclabs/hardhat-waffle");
require("hardhat-gas-reporter");
// TODO: Add your Alchemy API key and Goerli private key here.
const ALCHEMY_API_KEY = "";
const ALCHEMY_SEPOLIA_API_KEY = "";

const GOERLI_PRIVATE_KEY = "";

const COINMARKETCAP_API_KEY = "";
module.exports = {
    solidity: "0.8.6",
    settings: {
        optimizer: {
            enabled: true,
            runs: 300,
        },
    },
    gasReporter: {
        enabled: true,
        currency: "USD",
        showTimeSpent: true,
        coinmarketcap: COINMARKETCAP_API_KEY,
        optimizer: true,
    },
    networks: {
        goerli: {
            url: `https://eth-goerli.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
            accounts: [GOERLI_PRIVATE_KEY],
        },
        sepolia: {
            url: `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_SEPOLIA_API_KEY}`,
            accounts: [GOERLI_PRIVATE_KEY],
        },
    },
};
