/* global ethers task */
require("@nomiclabs/hardhat-waffle");

// TODO: Add your Alchemy API key and Goerli private key here.
const ALCHEMY_API_KEY = "sLYxjH129WHfYzOQ1B4bG2HSuwnMATFM";
const ALCHEMY_SEPOLIA_API_KEY = "7meorxsLekHMmAEpl30-6O8_mEVGQKJC";

const GOERLI_PRIVATE_KEY =
    "137f46cb8f4dd2529b695905f03c74261a901ddadbcda987c24fd573edaa4ec7";
module.exports = {
    solidity: "0.8.6",
    settings: {
        optimizer: {
            enabled: true,
            runs: 200,
        },
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
