// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract StartFacet {
    event taskCompleted(string taskName);

    function Start() public returns (bool) {
        if ((LibDiamond.preconditions() & 0x1 == 0x1)) {
            LibDiamond.step((LibDiamond.preconditions() & ~uint(0x1)) | 0x1800);
            emit taskCompleted("Start");
            return true;
        }
        return false;
    }
}
