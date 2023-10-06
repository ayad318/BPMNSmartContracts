// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

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

contract UUPSGrainSupplyChain is
    Initializable,
    OwnableUpgradeable,
    UUPSUpgradeable
{
    event taskCompleted(string taskName);

    uint preconditions = 0x1;

    // ---------- PROCESS VARIABLES
    uint consignmentWeight;
    bool isLoanAccepted;
    bool titleCreationSuccess;
    bool isDirectSale;
    bytes32 titleId;
    bool titleTransferSuccess;
    uint truckWeightWithoutConsignment;
    address buyer;
    uint truckWeightWithConsignment;
    uint grainQuality;
    // ----------------------------

    // -------- EXTERNAL SMART CONTRACT ADDRESSES
    // TODO: Change this address to the address of the GrainTitle_Registry contract
    address addressOfGrainTitle_Registry =
        0x456771DBfEA87606bBBDb39BF658608D1b57eC82;

    // ------------------------------------

    // It looks like only 1 contract gets deploed not a proxy and a separate logic contract
    // As per https://docs.openzeppelin.com/upgrades-plugins/1.x/writing-upgradeable logic
    // contract can't have a constructor. I'm confused as we have both constructor and
    // initialize functions in same contract
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
        consignmentWeight = 0;
        isLoanAccepted = false;
        titleCreationSuccess = false;
        isDirectSale = false;
        titleId = 0x0;
        titleTransferSuccess = false;
        truckWeightWithoutConsignment = 0;
        buyer = 0x0000000000000000000000000000000000000000;
        truckWeightWithConsignment = 0;
        grainQuality = 0;
        Start();
    }

    function initialize() public initializer {
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

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
            titleTransferSuccess = instanceOfGrainTitle_Registry
                .record_ownership_transfer(titleId, buyer);
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
            titleId = _titleId;
            GrainTitle_Registry instanceOfGrainTitle_Registry = GrainTitle_Registry(
                    addressOfGrainTitle_Registry
                );
            titleCreationSuccess = instanceOfGrainTitle_Registry.record_create(
                _titleId,
                grainQuality,
                consignmentWeight
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
            // ----------------------
            isLoanAccepted = _isLoanAccepted;
            // ----------------------
            // ----------------------
            if (isLoanAccepted == true) predicates |= 0x20000;
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
            // ----------------------
            grainQuality = _grainQuality;
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
            // ----------------------
            if (isDirectSale == true) predicates |= 0x10000;
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
            // ----------------------
            truckWeightWithoutConsignment = _truckWeightWithoutConsignment;
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
            // ----------------------
            truckWeightWithConsignment = _truckWeightWithConsignment;
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
            titleTransferSuccess = instanceOfGrainTitle_Registry
                .record_ownership_transfer(titleId, buyer);
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
            consignmentWeight =
                truckWeightWithConsignment -
                truckWeightWithoutConsignment;
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
}
