require("@nomicfoundation/hardhat-toolbox");

// TODO: Add your Alchemy API key and Goerli private key here.
const ALCHEMY_API_KEY = "Add your Alchemy API key here";
const ALCHEMY_SEPOLIA_API_KEY = "Add your Alchemy Sepolia API key here";

const GOERLI_PRIVATE_KEY = "Add your Goerli private key here";

module.exports = {
    solidity: "0.8.19",

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
