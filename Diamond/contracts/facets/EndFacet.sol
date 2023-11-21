// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract EndFacet {
    event taskCompleted(string taskName);

    function End() public returns (bool) {
        if ((LibDiamond.preconditions() & 0x2400 == 0x2400)) {
            LibDiamond.step(LibDiamond.preconditions() & ~uint(0x2400));
            emit taskCompleted("End");
            return true;
        }
        return false;
    }
}
