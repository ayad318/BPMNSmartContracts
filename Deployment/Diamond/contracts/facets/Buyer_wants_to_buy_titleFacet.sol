// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract Buyer_wants_to_buy_titleFacet {
    event taskCompleted(string taskName);

    function Buyer_wants_to_buy_title() public returns (bool) {
        uint predicates = 0;
        if ((LibDiamond.preconditions() & 0x8 == 0x8)) {
            // ----------------------
            if (LibDiamond.isDirectSale() == true) predicates |= 0x10000;
            // ----------------------
            LibDiamond.step(
                (LibDiamond.preconditions() & ~uint((0x8 | 0x10000))) |
                    0x2 |
                    predicates
            );
            emit taskCompleted("Buyer_wants_to_buy_title");
            return true;
        }
        return false;
    }
}
