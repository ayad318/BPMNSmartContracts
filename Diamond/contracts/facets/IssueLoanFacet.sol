// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {ProcessVariablesFacet} from "./ProcessVariablesFacet.sol";

contract IssueLoanFacet {
    event taskCompleted(string taskName);

    address processvariablesfacetaddress = 0x0000000000000000000000000000000000000000;

    constructor(address _processvariablesfacetaddress) {
        processvariablesfacetaddress = _processvariablesfacetaddress;
    }

    function Issue_loan() external returns (bool) {
        ProcessVariablesFacet processVariablesFacet = ProcessVariablesFacet(processvariablesfacetaddress);
        if ((processVariablesFacet.getPreconditions() & (0x200 | 0x20000) == (0x200 | 0x20000))) {
            processVariablesFacet.step((processVariablesFacet.getPreconditions() & ~uint(0x200)) | 0x40);
            emit taskCompleted("Issue_loan");
            return true;
        }
        return false;
    }
}
