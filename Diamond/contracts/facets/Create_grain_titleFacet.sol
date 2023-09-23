// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {ProcessVariablesFacet} from "./ProcessVariablesFacet.sol";
import {GrainTitleRegistry} from "../interfaces/GrainTitleRegistry.sol";

contract Create_grain_titleFacet {
    event taskCompleted(string taskName);

    address processvariablesfacetaddress = 0x0000000000000000000000000000000000000000;

    constructor(address _processvariablesfacetaddress) {
        processvariablesfacetaddress = _processvariablesfacetaddress;
    }

    function Create_grain_title(bytes32 _titleId) public returns (bool) {
        ProcessVariablesFacet processVariablesFacet = ProcessVariablesFacet(processvariablesfacetaddress);
        if ((processVariablesFacet.getPreconditions() & 0x84 == 0x84)) {
            // ----------------------
            processVariablesFacet.setTitleId(_titleId);
            GrainTitleRegistry instanceOfGrainTitle_Registry = GrainTitleRegistry(processVariablesFacet.getGrainTitleRegistryAddress());
            processVariablesFacet.setTitleCreationSuccess(
                instanceOfGrainTitle_Registry.record_create(
                    _titleId,
                    processVariablesFacet.getGrainQuality(),
                    processVariablesFacet.getConsignmentWeight()
                )
            );
            // ----------------------
            processVariablesFacet.step((processVariablesFacet.getPreconditions() & ~uint(0x84)) | 0x8);
            emit taskCompleted("Create_grain_title");
            return true;
        }
        return false;
    }
}
