// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {ProcessVariablesFacet} from "./ProcessVariablesFacet.sol";

contract Buyer_wants_to_buy_titleFacet {
    event taskCompleted(string taskName);

    address processvariablesfacetaddress = 0x0000000000000000000000000000000000000000;

    constructor(address _processvariablesfacetaddress) {
        processvariablesfacetaddress = _processvariablesfacetaddress;
    }

    function Buyer_wants_to_buy_title() public returns (bool) {
        ProcessVariablesFacet processVariablesFacet = ProcessVariablesFacet(processvariablesfacetaddress);
        uint predicates = 0;
        if ((processVariablesFacet.getPreconditions() & 0x8 == 0x8)) {
            // ----------------------
            if (processVariablesFacet.getIsDirectSale() == true) predicates |= 0x10000;
            // ----------------------
            processVariablesFacet.step((processVariablesFacet.getPreconditions() & ~uint((0x8 | 0x10000))) | 0x2 | predicates);
            emit taskCompleted("Buyer_wants_to_buy_title");
            return true;
        }
        return false;
    }
}
