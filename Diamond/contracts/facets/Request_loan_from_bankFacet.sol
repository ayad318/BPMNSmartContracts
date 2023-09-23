// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {ProcessVariablesFacet} from "./ProcessVariablesFacet.sol";

contract Request_loan_from_bankFacet {
    event taskCompleted(string taskName);

    address processvariablesfacetaddress = 0x0000000000000000000000000000000000000000;

    constructor(address _processvariablesfacetaddress) {
        processvariablesfacetaddress = _processvariablesfacetaddress;
    }

    function Request_loan_from_bank(bool _isLoanAccepted) public returns (bool) {
        ProcessVariablesFacet processVariablesFacet = ProcessVariablesFacet(processvariablesfacetaddress);
        uint predicates = 0;
        if ((processVariablesFacet.getPreconditions() & (0x2 | 0x10000) == (0x2))) {
            // ----------------------
            processVariablesFacet.setIsLoanAccepted(_isLoanAccepted);
            // ----------------------
            // ----------------------
            if (processVariablesFacet.getIsLoanAccepted() == true) predicates |= 0x20000;
            // ----------------------
            processVariablesFacet.step((processVariablesFacet.getPreconditions() & ~uint((0x2 | 0x20000))) | 0x200 | predicates);
            emit taskCompleted("Request_loan_from_bank");
            return true;
        }
        return false;
    }
}
