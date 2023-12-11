const { expect } = require("chai");
const { deployDiamond } = require("../scripts/deployDiamond");

describe("Diamond Test: ", function () {
    it("Deploying Diamons: ", async function () {
        await deployDiamond();
        expect(1).to.not.equal(0);
    });
});
