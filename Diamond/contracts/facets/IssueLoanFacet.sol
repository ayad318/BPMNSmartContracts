// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract IssueLoanFacet {
    event taskCompleted(string taskName);

    function Issue_loan() external returns (bool) {
        if (
            (LibDiamond.preconditions() & (0x200 | 0x20000) ==
                (0x200 | 0x20000))
        ) {
            LibDiamond.step((LibDiamond.preconditions() & ~uint(0x200)) | 0x40);
            emit taskCompleted("Issue_loan");
            return true;
        }
        return false;
    }
}
