// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {ProcessVariablesFacet} from "./ProcessVariablesFacet.sol";
import {GrainTitleRegistry} from "../interfaces/GrainTitleRegistry.sol";

contract Transfer_title_to_Buyer_and_flagged_as_collateralFacet {
    event taskCompleted(string taskName);

    address processvariablesfacetaddress = 0x0000000000000000000000000000000000000000;

    constructor(address _processvariablesfacetaddress) {
        processvariablesfacetaddress = _processvariablesfacetaddress;
    }

    function Transfer_title_to_Buyer_and_flagged_as_collateral() public returns (bool) {
        ProcessVariablesFacet processVariablesFacet = ProcessVariablesFacet(processvariablesfacetaddress);
        if ((processVariablesFacet.getPreconditions() & 0x10 == 0x10)) {
            // ----------------------
            GrainTitleRegistry instanceOfGrainTitle_Registry = GrainTitleRegistry(processVariablesFacet.getGrainTitleRegistryAddress());
            processVariablesFacet.setTitleTransferSuccess(
                instanceOfGrainTitle_Registry.record_ownership_transfer(processVariablesFacet.getTitleId(), processVariablesFacet.getBuyer())
            );
            // ----------------------
            processVariablesFacet.step((processVariablesFacet.getPreconditions() & ~uint(0x10)) | 0x20);
            emit taskCompleted("Transfer_title_to_Buyer_and_flagged_as_collateral");
            return true;
        }
        return false;
    }
}
