// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract Quality_sample_takenFacet {
    event taskCompleted(string taskName);

    function Quality_sample_taken() public returns (bool) {
        if ((LibDiamond.preconditions() & 0x800 == 0x800)) {
            LibDiamond.step(
                (LibDiamond.preconditions() & ~uint(0x800)) | 0x100
            );
            emit taskCompleted("Quality_sample_taken");
            return true;
        }
        return false;
    }
}
