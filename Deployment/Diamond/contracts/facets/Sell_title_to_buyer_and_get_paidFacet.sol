// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {GrainTitleRegistry} from "../interfaces/GrainTitleRegistry.sol";

contract Sell_title_to_buyer_and_get_paidFacet {
    event taskCompleted(string taskName);

    function Sell_title_to_buyer_and_get_paid() public returns (bool) {
        if ((LibDiamond.preconditions() & (0x2 | 0x10000) == (0x2 | 0x10000))) {
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
            LibDiamond.step((LibDiamond.preconditions() & ~uint(0x2)) | 0x400);
            emit taskCompleted("Sell_title_to_buyer_and_get_paid");
            return true;
        }
        return false;
    }
}
