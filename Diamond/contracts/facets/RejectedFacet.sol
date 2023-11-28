// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract RejectedFacet {
    event taskCompleted(string taskName);

    function Reject() external returns (bool) {
        if (LibDiamond.preconditions() & (0x200 | 0x20000) == (0x200)) {
            LibDiamond.step(LibDiamond.preconditions() & ~uint(0x200));
            emit taskCompleted("Reject");
            return true;
        }
        return false;
    }
}
