// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {GrainTitleRegistry} from "../interfaces/GrainTitleRegistry.sol";

contract Transfer_title_to_Buyer_and_flagged_as_collateralFacet {
    event taskCompleted(string taskName);

    function Transfer_title_to_Buyer_and_flagged_as_collateral()
        public
        returns (bool)
    {
        if ((LibDiamond.preconditions() & 0x10 == 0x10)) {
            // ----------------------
            GrainTitleRegistry instanceOfGrainTitle_Registry = GrainTitleRegistry(
                    LibDiamond.addressOfGrainTitle_Registry()
                );
            LibDiamond.setTitleTransferSuccess(
                instanceOfGrainTitle_Registry.record_ownership_transfer(
                    LibDiamond.titleId(),
                    LibDiamond.buyer()
                )
            );
            // ----------------------
            LibDiamond.step((LibDiamond.preconditions() & ~uint(0x10)) | 0x20);
            emit taskCompleted(
                "Transfer_title_to_Buyer_and_flagged_as_collateral"
            );
            return true;
        }
        return false;
    }
}
