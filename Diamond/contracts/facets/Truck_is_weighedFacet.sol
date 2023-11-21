// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract Truck_is_weighedFacet {
    event taskCompleted(string taskName);

    function Truck_is_weighed(
        uint _truckWeightWithConsignment
    ) public returns (bool) {
        if ((LibDiamond.preconditions() & 0x1000 == 0x1000)) {
            // ----------------------
            LibDiamond.setTruckWeightWithConsignment(
                _truckWeightWithConsignment
            );
            // ----------------------
            LibDiamond.step(
                (LibDiamond.preconditions() & ~uint(0x1000)) | 0x4000
            );
            emit taskCompleted("Truck_is_weighed");
            return true;
        }
        return false;
    }
}
