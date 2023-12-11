// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract Get_paidFacet {
    event taskCompleted(string taskName);

    function Get_paid() public returns (bool) {
        if ((LibDiamond.preconditions() & 0x40 == 0x40)) {
            LibDiamond.step((LibDiamond.preconditions() & ~uint(0x40)) | 0x10);
            emit taskCompleted("Get_paid");
            return true;
        }
        return false;
    }
}
