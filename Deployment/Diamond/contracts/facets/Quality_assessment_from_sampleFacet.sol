// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract Quality_assessment_from_sampleFacet {
    event taskCompleted(string taskName);

    function Quality_assessment_from_sample(
        uint _grainQuality
    ) public returns (bool) {
        if ((LibDiamond.preconditions() & 0x100 == 0x100)) {
            // ----------------------
            LibDiamond.setGrainQuality(_grainQuality);
            // ----------------------
            LibDiamond.step((LibDiamond.preconditions() & ~uint(0x100)) | 0x80);
            emit taskCompleted("Quality_assessment_from_sample");
            return true;
        }
        return false;
    }
}
