// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {ProcessVariablesFacet} from "./ProcessVariablesFacet.sol";

contract Quality_assessment_from_sampleFacet {
    event taskCompleted(string taskName);

    address processvariablesfacetaddress = 0x0000000000000000000000000000000000000000;

    constructor(address _processvariablesfacetaddress) {
        processvariablesfacetaddress = _processvariablesfacetaddress;
    }

    function Quality_assessment_from_sample(uint _grainQuality) public returns (bool) {
        ProcessVariablesFacet processVariablesFacet = ProcessVariablesFacet(processvariablesfacetaddress);
        if ((processVariablesFacet.getPreconditions() & 0x100 == 0x100)) {
            // ----------------------
            processVariablesFacet.setGrainQuality(_grainQuality);
            // ----------------------
            processVariablesFacet.step((processVariablesFacet.getPreconditions() & ~uint(0x100)) | 0x80);
            emit taskCompleted("Quality_assessment_from_sample");
            return true;
        }
        return false;
    }
}
