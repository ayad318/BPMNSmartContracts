const {
    time,
    loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { assert } = require("chai");

let Data, Logic, GrainTitleRegistry;
let dataContract, logicContract, grainTitleRegistryContract;
describe("Data and Logic Basic Test", function () {
    before(async () => {
        GrainTitleRegistry = await ethers.getContractFactory(
            "GrainTitleRegistry"
        );
        Data = await ethers.getContractFactory("Data");
        Logic = await ethers.getContractFactory("Logic");

        grainTitleRegistryContract = await GrainTitleRegistry.deploy();
        await grainTitleRegistryContract.waitForDeployment();

        dataContract = await Data.deploy();
        await dataContract.waitForDeployment();

        logicContract = await Logic.deploy(
            dataContract.address,
            grainTitleRegistryContract.address
        );
        await logicContract.waitForDeployment();

        await dataContract.setLogicContract(logicContract.address);
        console.log("Data Contract Address: ", dataContract.address);
    });
    it("Should have the correct Owner", async function () {
        expect(
            await dataContract.getOwner(),
            await ethers.getSigners()[0].getAddress()
        );
    });
});
