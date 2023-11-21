/* global ethers */
/* eslint prefer-const: "off" */

const {
    getSelectors,
    removeSelectors,
    FacetCutAction,
} = require("./libraries/diamond.js");

async function deployDiamond() {
    const accounts = await ethers.getSigners();
    const contractOwner = accounts[0];

    // Library deployment
    const lib = await ethers.getContractFactory("LibDiamond");
    const libDiamond = await lib.deploy();
    await libDiamond.deployed();
    console.log("Library Address depolyed: " + libDiamond.address);

    // deploy DiamondCutFacet
    const DiamondCutFacet = await ethers.getContractFactory("DiamondCutFacet");
    const diamondCutFacet = await DiamondCutFacet.deploy();
    await diamondCutFacet.deployed();
    console.log("DiamondCutFacet deployed:", diamondCutFacet.address);

    // deploy Diamond
    const Diamond = await ethers.getContractFactory("Diamond");
    const diamond = await Diamond.deploy(
        contractOwner.address,
        diamondCutFacet.address
    );
    await diamond.deployed();
    console.log("Diamond deployed:", diamond.address);

    // deploy DiamondInit
    // DiamondInit provides a function that is called when the diamond is upgraded to initialize state variables
    // Read about how the diamondCut function works here: https://eips.ethereum.org/EIPS/eip-2535#addingreplacingremoving-functions
    const DiamondInit = await ethers.getContractFactory("DiamondInit");
    const diamondInit = await DiamondInit.deploy();
    await diamondInit.deployed();
    console.log("DiamondInit deployed:", diamondInit.address);

    // deploy facets
    console.log("");
    console.log("Deploying facets");
    const FacetNames = ["DiamondLoupeFacet", "OwnershipFacet"];

    const cut = [];
    let ProcessVariablesFacetAddress;
    for (const FacetName of FacetNames) {
        const Facet = await ethers.getContractFactory(FacetName);
        const facet = await Facet.deploy();
        await facet.deployed();
        // if (FacetName === "ProcessVariablesFacet") {
        //     ProcessVariablesFacetAddress = facet.address;
        //     await facet.initialize();
        // }

        console.log(`${FacetName} deployed: ${facet.address}`);
        cut.push({
            facetAddress: facet.address,
            action: FacetCutAction.Add,
            functionSelectors: getSelectors(facet),
        });
    }

    // upgrade diamond with facets
    console.log("");
    console.log("Diamond Cut:", cut);
    const diamondCut = await ethers.getContractAt(
        "IDiamondCut",
        diamond.address
    );
    let tx;
    let receipt;
    // call to init function
    let functionCall = diamondInit.interface.encodeFunctionData("init");
    tx = await diamondCut.diamondCut(cut, diamondInit.address, functionCall);
    console.log("Diamond cut tx: ", tx.hash);
    receipt = await tx.wait();
    if (!receipt.status) {
        throw Error(`Diamond upgrade failed: ${tx.hash}`);
    }
    console.log("Completed diamond cut");

    // deploy BPMN facets
    console.log("");
    console.log("Deploying BPMN facets");

    const BPMNFacetNames = [
        "Buyer_wants_to_buy_titleFacet",
        "Create_grain_titleFacet",
        "EndFacet",
        "Get_paidFacet",
        "Grain_dropped_into_siloFacet",
        "IssueLoanFacet",
        "Quality_assessment_from_sampleFacet",
        "Quality_sample_takenFacet",
        "RejectedFacet",
        "Request_loan_from_bankFacet",
        "Sell_title_to_buyer_and_get_paidFacet",
        "StartFacet",
        "Transfer_title_to_Buyer_and_flagged_as_collateralFacet",
        "Truck_is_weighed_againFacet",
        "Truck_is_weighedFacet",
    ];

    const BPMNcut = [];

    for (const FacetName of BPMNFacetNames) {
        const Facet = await ethers.getContractFactory(FacetName, {
            libraries: { LibDiamond: libDiamond.address },
        });
        const facet = await Facet.deploy();
        await facet.deployed();
        console.log(`${FacetName} deployed: ${facet.address}`);
        const functionSelectors = getSelectors(facet);

        BPMNcut.push({
            facetAddress: facet.address,
            action: FacetCutAction.Add,
            functionSelectors: functionSelectors,
        });
    }

    // upgrade diamond with facets
    console.log("");
    console.log("Diamond BPMNcut:", BPMNcut);

    const BPMNdiamondCut = await ethers.getContractAt(
        "IDiamondCut",
        diamond.address
    );
    let BPMNtx;
    let BPMNreceipt;
    // call to init function
    let BPMNfunctionCall = diamondInit.interface.encodeFunctionData("init");
    BPMNtx = await BPMNdiamondCut.diamondCut(
        BPMNcut,
        diamondInit.address,
        BPMNfunctionCall
    );
    console.log("Diamond BPMNcut BPMNtx: ", BPMNtx.hash);
    BPMNreceipt = await BPMNtx.wait();
    if (!BPMNreceipt.status) {
        throw Error(`Diamond upgrade failed: ${BPMNtx.hash}`);
    }
    console.log("Completed diamond BPMNcut");
    return diamond.address;
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
    deployDiamond()
        .then(() => process.exit(0))
        .catch((error) => {
            console.error(error);
            process.exit(1);
        });
}

exports.deployDiamond = deployDiamond;
