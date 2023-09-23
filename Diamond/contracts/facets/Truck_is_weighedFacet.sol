// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {ProcessVariablesFacet} from "./ProcessVariablesFacet.sol";

contract Truck_is_weighedFacet {
    event taskCompleted(string taskName);

    address processvariablesfacetaddress = 0x0000000000000000000000000000000000000000;

    constructor(address _processvariablesfacetaddress) {
        processvariablesfacetaddress = _processvariablesfacetaddress;
    }

    function Truck_is_weighed(uint _truckWeightWithConsignment) public returns (bool) {
        ProcessVariablesFacet processVariablesFacet = ProcessVariablesFacet(processvariablesfacetaddress);
        if ((processVariablesFacet.getPreconditions() & 0x1000 == 0x1000)) {
            // ----------------------
            processVariablesFacet.setTruckWeightWithConsignment(_truckWeightWithConsignment);
            // ----------------------
            processVariablesFacet.step((processVariablesFacet.getPreconditions() & ~uint(0x1000)) | 0x4000);
            emit taskCompleted("Truck_is_weighed");
            return true;
        }
        return false;
    }
}
