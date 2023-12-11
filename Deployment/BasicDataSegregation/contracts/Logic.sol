// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Data.sol";

// -------- EXTERNAL SMART CONTRACT INTERFACES
interface GrainTitle_Registry {
    function record_get_state(bytes32 record_id) external returns (uint8 state);

    function record_does_exist(bytes32 record_id) external returns (bool exist);

    function record_ownership_transfer(
        bytes32 record_id,
        address new_owner
    ) external returns (bool valid);

    function get_all_record_ids()
        external
        returns (bytes32[] memory record_ids);

    function record_get_attrs(
        bytes32 record_id
    ) external returns (uint256 quality, uint256 weight);

    function record_get_owner(
        bytes32 record_id
    ) external returns (address record_owner);

    function record_create(
        bytes32 record_id,
        uint256 quality,
        uint256 weight
    ) external returns (bool valid);

    function registry_admin() external returns (address);
}

contract Logic {
    event taskCompleted(string taskName);

    uint preconditions = 0x1;

    // -------- EXTERNAL SMART CONTRACT ADDRESSES
    // TODO: Change the address to the GrainTitleRegistry address
    address addressOfGrainTitle_Registry =
        0x456771DBfEA87606bBBDb39BF658608D1b57eC82;

    // ------------------------------------
    // TODO: Change the address to the Data address
    address dataContractAddress = 0xC43487d09D5412FEba991178D5ab815f855e1b10;

    constructor() {
        Start();
    }

    function Issue_loan() public returns (bool) {
        if ((preconditions & (0x200 | 0x20000) == (0x200 | 0x20000))) {
            step((preconditions & ~uint(0x200)) | 0x40);
            emit taskCompleted("Issue_loan");
            return true;
        }
        return false;
    }

    function Start() public returns (bool) {
        if ((preconditions & 0x1 == 0x1)) {
            step((preconditions & ~uint(0x1)) | 0x1800);
            emit taskCompleted("Start");
            return true;
        }
        return false;
    }

    function Rejected() public returns (bool) {
        if ((preconditions & (0x200 | 0x20000) == (0x200))) {
            step(preconditions & ~uint(0x200));
            emit taskCompleted("Rejected");
            return true;
        }
        return false;
    }

    function Transfer_title_to_Buyer_and_flagged_as_collateral()
        public
        returns (bool)
    {
        if ((preconditions & 0x10 == 0x10)) {
            // ----------------------
            GrainTitle_Registry instanceOfGrainTitle_Registry = GrainTitle_Registry(
                    addressOfGrainTitle_Registry
                );
            Data dataContract = Data(dataContractAddress);
            dataContract.setTitleTransferSuccess(
                instanceOfGrainTitle_Registry.record_ownership_transfer(
                    dataContract.getTitleId(),
                    dataContract.getBuyer()
                )
            );
            // ----------------------
            step((preconditions & ~uint(0x10)) | 0x2000);
            emit taskCompleted(
                "Transfer_title_to_Buyer_and_flagged_as_collateral"
            );
            return true;
        }
        return false;
    }

    function Grain_dropped_into_silo() public returns (bool) {
        if ((preconditions & 0x4000 == 0x4000)) {
            step((preconditions & ~uint(0x4000)) | 0x20);
            emit taskCompleted("Grain_dropped_into_silo");
            return true;
        }
        return false;
    }

    function Create_grain_title(bytes32 _titleId) public returns (bool) {
        if ((preconditions & 0x84 == 0x84)) {
            // ----------------------
            Data dataContract = Data(dataContractAddress);
            dataContract.setTitleId(_titleId);
            GrainTitle_Registry instanceOfGrainTitle_Registry = GrainTitle_Registry(
                    addressOfGrainTitle_Registry
                );
            dataContract.setTitleCreationSuccess(
                instanceOfGrainTitle_Registry.record_create(
                    _titleId,
                    dataContract.getGrainQuality(),
                    dataContract.getConsignmentWeight()
                )
            );
            // ----------------------
            step((preconditions & ~uint(0x84)) | 0x8);
            emit taskCompleted("Create_grain_title");
            return true;
        }
        return false;
    }

    function Request_loan_from_bank(
        bool _isLoanAccepted
    ) public returns (bool) {
        uint predicates = 0;
        if ((preconditions & (0x2 | 0x10000) == (0x2))) {
            Data dataContract = Data(dataContractAddress);
            // ----------------------
            dataContract.setIsLoanAccepted(_isLoanAccepted);
            // ----------------------
            // ----------------------
            if (dataContract.getIsLoanAccepted() == true) predicates |= 0x20000;
            // ----------------------
            step((preconditions & ~uint((0x2 | 0x20000))) | 0x200 | predicates);
            emit taskCompleted("Request_loan_from_bank");
            return true;
        }
        return false;
    }

    function Quality_sample_taken() public returns (bool) {
        if ((preconditions & 0x800 == 0x800)) {
            step((preconditions & ~uint(0x800)) | 0x100);
            emit taskCompleted("Quality_sample_taken");
            return true;
        }
        return false;
    }

    function Quality_assessment_from_sample(
        uint _grainQuality
    ) public returns (bool) {
        if ((preconditions & 0x100 == 0x100)) {
            Data dataContract = Data(dataContractAddress);
            // ----------------------
            dataContract.setGrainQuality(_grainQuality);
            // ----------------------
            step((preconditions & ~uint(0x100)) | 0x80);
            emit taskCompleted("Quality_assessment_from_sample");
            return true;
        }
        return false;
    }

    function Buyer_wants_to_buy_title() public returns (bool) {
        uint predicates = 0;
        if ((preconditions & 0x8 == 0x8)) {
            Data dataContract = Data(dataContractAddress);
            // ----------------------
            if (dataContract.getIsDirectSale() == true) predicates |= 0x10000;
            // ----------------------
            step((preconditions & ~uint((0x8 | 0x10000))) | 0x2 | predicates);
            emit taskCompleted("Buyer_wants_to_buy_title");
            return true;
        }
        return false;
    }

    function End() public returns (bool) {
        if ((preconditions & 0x2400 == 0x2400)) {
            step(preconditions & ~uint(0x2400));
            emit taskCompleted("End");
            return true;
        }
        return false;
    }

    function Truck_is_weighed_again(
        uint _truckWeightWithoutConsignment
    ) public returns (bool) {
        if ((preconditions & 0x20 == 0x20)) {
            Data dataContract = Data(dataContractAddress);
            // ----------------------
            dataContract.setTruckWeightWithoutConsignment(
                _truckWeightWithoutConsignment
            );
            // ----------------------
            step((preconditions & ~uint(0x20)) | 0x8000);
            emit taskCompleted("Truck_is_weighed_again");
            return true;
        }
        return false;
    }

    function Truck_is_weighed(
        uint _truckWeightWithConsignment
    ) public returns (bool) {
        if ((preconditions & 0x1000 == 0x1000)) {
            Data dataContract = Data(dataContractAddress);
            // ----------------------
            dataContract.setTruckWeightWithConsignment(
                _truckWeightWithConsignment
            );
            // ----------------------
            step((preconditions & ~uint(0x1000)) | 0x4000);
            emit taskCompleted("Truck_is_weighed");
            return true;
        }
        return false;
    }

    function Sell_title_to_buyer_and_get_paid() public returns (bool) {
        if ((preconditions & (0x2 | 0x10000) == (0x2 | 0x10000))) {
            // ----------------------
            GrainTitle_Registry instanceOfGrainTitle_Registry = GrainTitle_Registry(
                    addressOfGrainTitle_Registry
                );
            Data dataContract = Data(dataContractAddress);
            dataContract.setTitleTransferSuccess(
                instanceOfGrainTitle_Registry.record_ownership_transfer(
                    dataContract.getTitleId(),
                    dataContract.getBuyer()
                )
            );
            // ----------------------
            step((preconditions & ~uint(0x2)) | 0x400);
            emit taskCompleted("Sell_title_to_buyer_and_get_paid");
            return true;
        }
        return false;
    }

    function Get_paid() public returns (bool) {
        if ((preconditions & 0x40 == 0x40)) {
            step((preconditions & ~uint(0x40)) | 0x10);
            emit taskCompleted("Get_paid");
            return true;
        }
        return false;
    }

    function Calculate_grain_weight(
        uint preconditionsp
    ) internal returns (uint) {
        if ((preconditionsp & 0x8000 == 0x8000)) {
            return (preconditionsp & ~uint(0x8000)) | 0x4;
        } else {
            Data dataContract = Data(dataContractAddress);
            dataContract.setConsignmentWeight(
                dataContract.getTruckWeightWithConsignment() -
                    dataContract.getTruckWeightWithoutConsignment()
            );
            return preconditionsp;
        }
    }

    function step(uint preconditionsp) internal {
        if (preconditionsp & 0xffff == 0) {
            preconditions = 0;
            return;
        }
        bool done = false;
        while (!done) {
            if ((preconditionsp & 0x8000 == 0x8000)) {
                preconditionsp = Calculate_grain_weight(preconditionsp);
                continue;
            }
            done = true;
        }
        preconditions = preconditionsp;
    }

    function isProcessInstanceCompleted() public view returns (bool) {
        return getEnablement() == 0;
    }

    function bitSetter_nopredicates(
        uint value,
        uint ormask,
        uint mask
    ) internal pure returns (uint) {
        if (value & mask == mask) {
            return ormask;
        }
        return 0;
    }

    function bitSetter_onlyppredicates(
        uint value,
        uint ormask,
        uint mask1,
        uint ppred
    ) internal pure returns (uint) {
        if ((value & mask1 == mask1) && (value & ppred == ppred)) {
            return ormask;
        }
        return 0;
    }

    function bitSetter_onlynpredicates(
        uint value,
        uint ormask,
        uint mask,
        uint npred
    ) internal pure returns (uint) {
        if ((value & mask == mask) && (value & npred == 0)) {
            return ormask;
        }
        return 0;
    }

    function bitSetter_bothpredicates(
        uint value,
        uint ormask,
        uint mask1,
        uint ppred,
        uint npred
    ) internal pure returns (uint) {
        if (
            (value & mask1 == mask1) &&
            (value & ppred == ppred) &&
            (value & npred == 0)
        ) {
            return ormask;
        }
        return 0;
    }

    function getEnablement() public view returns (uint) {
        uint enabledTasks = 0;

        // Start

        //if ( (preconditions & 0x1 == 0x1) )
        //    enabledTasks |= 0x1000;
        // no predicates here
        enabledTasks |= bitSetter_nopredicates(preconditions, 0x1000, 0x1);

        // Grain_dropped_into_silo

        //if ( (preconditions & 0x4000 == 0x4000) )
        //    enabledTasks |= 0x20;
        // no predicates here
        enabledTasks |= bitSetter_nopredicates(preconditions, 0x20, 0x4000);

        // Quality_sample_taken

        //if ( (preconditions & 0x800 == 0x800) )
        //    enabledTasks |= 0x100;
        // no predicates here
        enabledTasks |= bitSetter_nopredicates(preconditions, 0x100, 0x800);

        // Truck_is_weighed

        //if ( (preconditions & 0x1000 == 0x1000) )
        //    enabledTasks |= 0x4000;
        // no predicates here
        enabledTasks |= bitSetter_nopredicates(preconditions, 0x4000, 0x1000);

        // Truck_is_weighed_again

        //if ( (preconditions & 0x20 == 0x20) )
        //    enabledTasks |= 0x8000;
        // no predicates here
        enabledTasks |= bitSetter_nopredicates(preconditions, 0x8000, 0x20);

        // Quality_assessment_from_sample

        //if ( (preconditions & 0x100 == 0x100) )
        //    enabledTasks |= 0x80;
        // no predicates here
        enabledTasks |= bitSetter_nopredicates(preconditions, 0x80, 0x100);

        // Create_grain_title

        //if ( (preconditions & 0x84 == 0x84) )
        //    enabledTasks |= 0x4;
        // no predicates here
        enabledTasks |= bitSetter_nopredicates(preconditions, 0x4, 0x84);

        // Sell_title_to_buyer_and_get_paid

        //if ( (preconditions & 0x2 == 0x2) && (preconditions & 0x10000 == 0x10000) )
        //    enabledTasks |= 0x800;
        // only ppredicates
        enabledTasks |= bitSetter_onlyppredicates(
            preconditions,
            0x800,
            0x2,
            0x10000
        );

        // Issue_loan

        //if ( (preconditions & 0x200 == 0x200) && (preconditions & 0x20000 == 0x20000) )
        //    enabledTasks |= 0x40;
        // only ppredicates
        enabledTasks |= bitSetter_onlyppredicates(
            preconditions,
            0x40,
            0x200,
            0x20000
        );

        // Get_paid

        //if ( (preconditions & 0x40 == 0x40) )
        //    enabledTasks |= 0x10;
        // no predicates here
        enabledTasks |= bitSetter_nopredicates(preconditions, 0x10, 0x40);

        // Transfer_title_to_Buyer_and_flagged_as_collateral

        //if ( (preconditions & 0x10 == 0x10) )
        //    enabledTasks |= 0x2000;
        // no predicates here
        enabledTasks |= bitSetter_nopredicates(preconditions, 0x2000, 0x10);

        // End

        //if ( (preconditions & 0x2400 == 0x2400) )
        //    enabledTasks |= 0x8;
        // no predicates here
        enabledTasks |= bitSetter_nopredicates(preconditions, 0x8, 0x2400);

        // Rejected

        //if ( (preconditions & 0x200 == 0x200) && (preconditions & 0x20000 == 0) )
        //    enabledTasks |= 0x200;
        // only npredicates
        enabledTasks |= bitSetter_onlynpredicates(
            preconditions,
            0x200,
            0x200,
            0x20000
        );

        // Request_loan_from_bank

        //if ( (preconditions & 0x2 == 0x2) && (preconditions & 0x10000 == 0) )
        //    enabledTasks |= 0x400;
        // only npredicates
        enabledTasks |= bitSetter_onlynpredicates(
            preconditions,
            0x400,
            0x2,
            0x10000
        );

        // Buyer_wants_to_buy_title

        //if ( (preconditions & 0x8 == 0x8) )
        //    enabledTasks |= 0x1;
        // no predicates here
        enabledTasks |= bitSetter_nopredicates(preconditions, 0x1, 0x8);

        return enabledTasks;
    }
    /*
// Library functions
    function uint2string(uint val) internal returns(string) {
        string memory result = new string(256);
        bytes memory result_bytes = bytes(result);
        uint i;
        for (i = 0; i < result_bytes.length; i++) {
            byte rem = (byte)((val % 10)+48);
            val = val / 10;
            result_bytes[i] = rem;
            if(val==0) {
                break;
            }
        }
        uint len = i;
        string memory out = new string(len+1);
        bytes memory out_bytes = bytes(out);
        for (i = 0; i <= len; i++) {
            out_bytes[i] = result_bytes[len-i];
        }
        return string(out_bytes);
    }
    function strConcat(string a, string b) internal returns(string) {
        return strConcat(a, b, "");
    }
    function strConcat(string a, string b, string c) internal returns(string) {
        bytes memory a_bytes = bytes(a);
        bytes memory b_bytes = bytes(b);
        bytes memory c_bytes = bytes(c);
        string memory result = new string(a_bytes.length + b_bytes.length + c_bytes.length);
        bytes memory result_bytes = bytes(result);
        uint i;
        uint pos = 0;
        for (i = 0; i < a_bytes.length; i++) result_bytes[pos++] = a_bytes[i];
        for (i = 0; i < b_bytes.length; i++) result_bytes[pos++] = b_bytes[i];
        for (i = 0; i < c_bytes.length; i++) result_bytes[pos++] = c_bytes[i];
        return string(result_bytes);
    }
*/
    // -------
}
