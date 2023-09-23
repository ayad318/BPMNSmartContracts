// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract ProcessVariablesFacet {
    uint preconditions = 0x1;

    // ---------- PROCESS VARIABLES
    uint consignmentWeight;
    bool isLoanAccepted;
    bool titleCreationSuccess;
    bool isDirectSale;
    bytes32 titleId;
    bool titleTransferSuccess;
    uint truckWeightWithoutConsignment;
    address buyer;
    uint truckWeightWithConsignment;
    uint grainQuality;
    // ----------------------------

    // -------- EXTERNAL SMART CONTRACT ADDRESSES TODO: Update the address
    address addressOfGrainTitle_Registry = 0x72a239b360041a1964A7BA3d36FF735498F4d203;

    // ------------------------------------

    constructor() {
        consignmentWeight = 0;
        isLoanAccepted = false;
        titleCreationSuccess = false;
        isDirectSale = false;
        titleId = 0x0;
        titleTransferSuccess = false;
        truckWeightWithoutConsignment = 0;
        buyer = 0x0000000000000000000000000000000000000000;
        truckWeightWithConsignment = 0;
        grainQuality = 0;
    }

    function Calculate_grain_weight(uint preconditionsp) internal returns (uint) {
        if ((preconditionsp & 0x8000 == 0x8000)) {
            return (preconditionsp & ~uint(0x8000)) | 0x4;
        } else {
            consignmentWeight = truckWeightWithConsignment - truckWeightWithoutConsignment;
            return preconditionsp;
        }
    }

    function step(uint preconditionsp) external {
        if (preconditionsp & 0xffff == 0) {
            preconditions = 0;
            return;
        }
        bool done = false;
        while (!done) {
            if ((preconditionsp & 0x8000 == 0x8000)) {
                preconditionsp = Calculate_grain_weight(preconditionsp);
                continue;
            }
            done = true;
        }
        preconditions = preconditionsp;
    }

    function getPreconditions() external view returns (uint) {
        return preconditions;
    }

    function setConsignmentWeight(uint _consignmentWeight) external {
        consignmentWeight = _consignmentWeight;
    }

    function getConsignmentWeight() external view returns (uint) {
        return consignmentWeight;
    }

    function setIsLoanAccepted(bool _isLoanAccepted) external {
        isLoanAccepted = _isLoanAccepted;
    }

    function getIsLoanAccepted() external view returns (bool) {
        return isLoanAccepted;
    }

    function setTitleCreationSuccess(bool _titleCreationSuccess) external {
        titleCreationSuccess = _titleCreationSuccess;
    }

    function getTitleCreationSuccess() external view returns (bool) {
        return titleCreationSuccess;
    }

    function setIsDirectSale(bool _isDirectSale) external {
        isDirectSale = _isDirectSale;
    }

    function getIsDirectSale() external view returns (bool) {
        return isDirectSale;
    }

    function setTitleId(bytes32 _titleId) external {
        titleId = _titleId;
    }

    function getTitleId() external view returns (bytes32) {
        return titleId;
    }

    function setTitleTransferSuccess(bool _titleTransferSuccess) external {
        titleTransferSuccess = _titleTransferSuccess;
    }

    function getTitleTransferSuccess() external view returns (bool) {
        return titleTransferSuccess;
    }

    function setTruckWeightWithoutConsignment(uint _truckWeightWithoutConsignment) external {
        truckWeightWithoutConsignment = _truckWeightWithoutConsignment;
    }

    function getTruckWeightWithoutConsignment() external view returns (uint) {
        return truckWeightWithoutConsignment;
    }

    function setBuyer(address _buyer) external {
        buyer = _buyer;
    }

    function getBuyer() external view returns (address) {
        return buyer;
    }

    function setTruckWeightWithConsignment(uint _truckWeightWithConsignment) external {
        truckWeightWithConsignment = _truckWeightWithConsignment;
    }

    function getTruckWeightWithConsignment() external view returns (uint) {
        return truckWeightWithConsignment;
    }

    function setGrainQuality(uint _grainQuality) external {
        grainQuality = _grainQuality;
    }

    function getGrainQuality() external view returns (uint) {
        return grainQuality;
    }

    function getGrainTitleRegistryAddress() external view returns (address) {
        return addressOfGrainTitle_Registry;
    }
}
