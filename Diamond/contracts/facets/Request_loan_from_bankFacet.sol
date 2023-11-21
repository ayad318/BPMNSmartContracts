// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract Request_loan_from_bankFacet {
    event taskCompleted(string taskName);

    function Request_loan_from_bank(
        bool _isLoanAccepted
    ) public returns (bool) {
        uint predicates = 0;
        if ((LibDiamond.preconditions() & (0x2 | 0x10000) == (0x2))) {
            // ----------------------
            LibDiamond.setIsLoanAccepted(_isLoanAccepted);
            // ----------------------
            // ----------------------
            if (LibDiamond.isLoanAccepted() == true) predicates |= 0x20000;
            // ----------------------
            LibDiamond.step(
                (LibDiamond.preconditions() & ~uint((0x2 | 0x20000))) |
                    0x200 |
                    predicates
            );
            emit taskCompleted("Request_loan_from_bank");
            return true;
        }
        return false;
    }
}
