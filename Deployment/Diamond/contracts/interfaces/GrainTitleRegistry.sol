// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// -------- EXTERNAL SMART CONTRACT INTERFACES
interface GrainTitleRegistry {
    function record_get_state(bytes32 record_id) external returns (uint8 state);

    function record_does_exist(bytes32 record_id) external returns (bool exist);

    function record_ownership_transfer(bytes32 record_id, address new_owner) external returns (bool valid);

    function get_all_record_ids() external returns (bytes32[] memory record_ids);

    function record_get_attrs(bytes32 record_id) external returns (uint256 quality, uint256 weight);

    function record_get_owner(bytes32 record_id) external returns (address record_owner);

    function record_create(bytes32 record_id, uint256 quality, uint256 weight) external returns (bool valid);

    function registry_admin() external returns (address);
}
