// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract Grain_dropped_into_siloFacet {
    event taskCompleted(string taskName);

    function Grain_dropped_into_silo() public returns (bool) {
        if ((LibDiamond.preconditions() & 0x4000 == 0x4000)) {
            LibDiamond.step(
                (LibDiamond.preconditions() & ~uint(0x4000)) | 0x20
            );
            emit taskCompleted("Grain_dropped_into_silo");
            return true;
        }
        return false;
    }
}
