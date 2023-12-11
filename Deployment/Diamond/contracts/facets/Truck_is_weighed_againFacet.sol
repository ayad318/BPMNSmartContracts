// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract Truck_is_weighed_againFacet {
    event taskCompleted(string taskName);

    function Truck_is_weighed_again(
        uint _truckWeightWithoutConsignment
    ) public returns (bool) {
        if ((LibDiamond.preconditions() & 0x20 == 0x20)) {
            // ----------------------
            LibDiamond.setTruckWeightWithoutConsignment(
                _truckWeightWithoutConsignment
            );
            // ----------------------
            LibDiamond.step(
                (LibDiamond.preconditions() & ~uint(0x20)) | 0x8000
            );
            emit taskCompleted("Truck_is_weighed_again");
            return true;
        }
        return false;
    }
}
