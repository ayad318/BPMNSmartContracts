// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {ProcessVariablesFacet} from "./ProcessVariablesFacet.sol";

contract Truck_is_weighed_againFacet {
    event taskCompleted(string taskName);

    address processvariablesfacetaddress = 0x0000000000000000000000000000000000000000;

    constructor(address _processvariablesfacetaddress) {
        processvariablesfacetaddress = _processvariablesfacetaddress;
    }

    function Truck_is_weighed_again(uint _truckWeightWithoutConsignment) public returns (bool) {
        ProcessVariablesFacet processVariablesFacet = ProcessVariablesFacet(processvariablesfacetaddress);
        if ((processVariablesFacet.getPreconditions() & 0x20 == 0x20)) {
            // ----------------------
            processVariablesFacet.setTruckWeightWithoutConsignment(_truckWeightWithoutConsignment);
            // ----------------------
            processVariablesFacet.step((processVariablesFacet.getPreconditions() & ~uint(0x20)) | 0x8000);
            emit taskCompleted("Truck_is_weighed_again");
            return true;
        }
        return false;
    }
}
