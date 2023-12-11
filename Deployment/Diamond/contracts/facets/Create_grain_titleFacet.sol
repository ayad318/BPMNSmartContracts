// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {GrainTitleRegistry} from "../interfaces/GrainTitleRegistry.sol";

contract Create_grain_titleFacet {
    event taskCompleted(string taskName);

    function Create_grain_title(bytes32 _titleId) public returns (bool) {
        if ((LibDiamond.preconditions() & 0x84 == 0x84)) {
            // ----------------------
            LibDiamond.setTitleId(_titleId);
            GrainTitleRegistry instanceOfGrainTitle_Registry = GrainTitleRegistry(
                    LibDiamond.addressOfGrainTitle_Registry()
                );
            LibDiamond.setTitleCreationSuccess(
                instanceOfGrainTitle_Registry.record_create(
                    _titleId,
                    LibDiamond.grainQuality(),
                    LibDiamond.consignmentWeight()
                )
            );
            // ----------------------
            LibDiamond.step((LibDiamond.preconditions() & ~uint(0x84)) | 0x8);
            emit taskCompleted("Create_grain_title");
            return true;
        }
        return false;
    }
}
