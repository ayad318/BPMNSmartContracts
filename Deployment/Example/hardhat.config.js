require("@nomicfoundation/hardhat-toolbox");
require("hardhat-gas-reporter");

const ALCHEMY_API_KEY = "";
const ALCHEMY_SEPOLIA_API_KEY = "";

const GOERLI_PRIVATE_KEY = "";

const COINMARKETCAP_API_KEY = "";
module.exports = {
    solidity: "0.8.19",
    settings: {
        optimizer: {
            // Toggles whether the optimizer is on or off.
            // It's good to keep it off for development
            // and turn on for when getting ready to launch.
            enabled: true,
            // The number of runs specifies roughly how often
            // the deployed code will be executed across the
            // life-time of the contract.
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
