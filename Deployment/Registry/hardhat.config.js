require("@nomicfoundation/hardhat-toolbox");

// TODO: Add your Alchemy API key and Goerli private key here.
const ALCHEMY_API_KEY = "";
const ALCHEMY_SEPOLIA_API_KEY = "";

const GOERLI_PRIVATE_KEY = "";

const COINMARKETCAP_API_KEY = "";
module.exports = {
    solidity: "0.5.0",

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
