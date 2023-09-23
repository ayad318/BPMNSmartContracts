// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {ProcessVariablesFacet} from "./ProcessVariablesFacet.sol";

contract Grain_dropped_into_siloFacet {
    event taskCompleted(string taskName);

    address processvariablesfacetaddress = 0x0000000000000000000000000000000000000000;

    constructor(address _processvariablesfacetaddress) {
        processvariablesfacetaddress = _processvariablesfacetaddress;
    }

    function Grain_dropped_into_silo() public returns (bool) {
        ProcessVariablesFacet processVariablesFacet = ProcessVariablesFacet(processvariablesfacetaddress);
        if ((processVariablesFacet.getPreconditions() & 0x4000 == 0x4000)) {
            processVariablesFacet.step((processVariablesFacet.getPreconditions() & ~uint(0x4000)) | 0x20);
            emit taskCompleted("Grain_dropped_into_silo");
            return true;
        }
        return false;
    }
}
