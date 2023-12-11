const { expect } = require("chai");

describe("Basic Data Segregation Test: ", function () {
    it("Deploying Data and Logic Contracts: ", async function () {
        dataContract = await hre.ethers.deployContract("Data");
        await dataContract.waitForDeployment();
        logicContract = await hre.ethers.deployContract("Logic");
        await logicContract.waitForDeployment();
        expect(dataContract.address).to.not.equal(0);
        expect(logicContract.address).to.not.equal(0);
    });
});
