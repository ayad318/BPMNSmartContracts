// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const { ethers, upgrades } = require("hardhat");

async function main() {
    const deploymentTimes = [];

    for (let i = 0; i < 10; i++) {
        const startTime = Date.now();
        const GrainSupplyChain = await ethers.getContractFactory(
            "UUPSGrainSupplyChain"
        );
        const uups = await upgrades.deployProxy(GrainSupplyChain);

        await uups.waitForDeployment();
        const endTime = Date.now();
        const deploymentTime = endTime - startTime;
        deploymentTimes.push(deploymentTime);

        await sleep(10000);
    }

    const minTime = Math.min(...deploymentTimes);
    const maxTime = Math.max(...deploymentTimes);
    const medianTime = calculateMedian(deploymentTimes);
    const averageTime = calculateAverage(deploymentTimes);

    const tableData = [
        { Metric: "Min Time", Value: `${minTime}ms` },
        { Metric: "Max Time", Value: `${maxTime}ms` },
        { Metric: "Median Time", Value: `${medianTime}ms` },
        { Metric: "Average Time", Value: `${averageTime}ms` },
    ];

    console.table(tableData);
}

function calculateMedian(arr) {
    const sortedArr = arr.sort((a, b) => a - b);
    const mid = Math.floor(sortedArr.length / 2);
    return sortedArr.length % 2 !== 0
        ? sortedArr[mid]
        : (sortedArr[mid - 1] + sortedArr[mid]) / 2;
}

function calculateAverage(arr) {
    const sum = arr.reduce((acc, val) => acc + val, 0);
    return sum / arr.length;
}

function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
