const { expect } = require("chai");

describe("GrainSupplyChain Test: ", function () {
    it("Deploying GrainSupplyChain: ", async function () {
        const Contract = await ethers.getContractFactory("GrainSupplyChain");
        const contract = await Contract.deploy();
        await contract.waitForDeployment();
        expect(contract.address).to.not.equal(0);
    });
});
