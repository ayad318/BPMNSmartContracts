const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("UUPS Test: ", function () {
    it("Deploying UUPS: ", async function () {
        const GrainSupplyChain = await ethers.getContractFactory(
            "UUPSGrainSupplyChain"
        );
        const uups = await upgrades.deployProxy(GrainSupplyChain);

        await uups.waitForDeployment();
        expect(uups.address).to.not.equal(0);
    });
});
