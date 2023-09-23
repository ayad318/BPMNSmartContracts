// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {ProcessVariablesFacet} from "./ProcessVariablesFacet.sol";
import {GrainTitleRegistry} from "../interfaces/GrainTitleRegistry.sol";

contract Sell_title_to_buyer_and_get_paidFacet {
    event taskCompleted(string taskName);

    address processvariablesfacetaddress = 0x0000000000000000000000000000000000000000;

    constructor(address _processvariablesfacetaddress) {
        processvariablesfacetaddress = _processvariablesfacetaddress;
    }

    function Sell_title_to_buyer_and_get_paid() public returns (bool) {
        ProcessVariablesFacet processVariablesFacet = ProcessVariablesFacet(processvariablesfacetaddress);
        if ((processVariablesFacet.getPreconditions() & (0x2 | 0x10000) == (0x2 | 0x10000))) {
            // ----------------------
            GrainTitleRegistry instanceOfGrainTitle_Registry = GrainTitleRegistry(processVariablesFacet.getGrainTitleRegistryAddress());
            processVariablesFacet.setTitleTransferSuccess(
                instanceOfGrainTitle_Registry.record_ownership_transfer(processVariablesFacet.getTitleId(), processVariablesFacet.getBuyer())
            );
            // ----------------------
            processVariablesFacet.step((processVariablesFacet.getPreconditions() & ~uint(0x2)) | 0x400);
            emit taskCompleted("Sell_title_to_buyer_and_get_paid");
            return true;
        }
        return false;
    }
}
