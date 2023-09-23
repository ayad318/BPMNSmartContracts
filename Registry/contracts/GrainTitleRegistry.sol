pragma solidity ^0.5.0;

// GrainTitle registry smart contract.
contract GrainTitleRegistry {
    enum RecordStates {
        NON_EXISTING,
        ACTIVE
    }

    // Data structure containing basic fields/attributes of a registry record.
    struct RecordAttributes {
        // Define record attributes here...
        uint quality;
        uint weight;
    }

    // Data structure representing a single registry record.
    struct Record {
        // Record owner can be an external Ethereum account,
        // or a smart contract representing an user group or Organisation.
        address owner;
        RecordStates state;
        RecordAttributes attrs;
    }

    mapping(bytes32 => Record) records;
    bytes32[] all_record_ids;

    // Admin of registry.
    address public registry_admin;

    // Registry constructor.
    constructor() public {
        // The user deploying the registry contract will be the registry admin.
        registry_admin = msg.sender;
    }

    // ========== CONTRACT EVENTS ==========

    // Emit the creation/deletion history of all records on the registry.
    event records_history(
        bytes32 indexed record_id,
        address indexed owner,
        uint timestamp,
        bool is_deleted
    );

    // Emit the history of all ownership transfers made for registry records.
    event record_ownership_transfer_history(
        bytes32 indexed record_id,
        address prev_owner,
        address new_owner
    );

    // ========== REGISTRY ADMIN FUNCTIONS ==========

    // Get the list of IDs for all registry records.
    function get_all_record_ids()
        public
        view
        returns (bytes32[] memory record_ids)
    {
        record_ids = all_record_ids;
    }

    // ========== INTERFACE FUNCTIONS IMPLEMENTATION ==========

    // Create a new registry record with the given attributes.
    function record_create(
        bytes32 record_id,
        uint quality,
        uint weight
    )
        public
        record_in_state(record_id, RecordStates.NON_EXISTING)
        returns (bool valid)
    {
        // The owner of the record
        address record_owner = msg.sender;

        // Create the record in smart contract storage
        _record_create(record_id, record_owner, quality, weight);
        // Add record to list, set record state to ACTIVE
        all_record_ids.push(record_id);
        records[record_id].state = RecordStates.ACTIVE;

        // Emit relevant contract events
        emit records_history(record_id, record_owner, block.timestamp, false);

        return true;
    }

    // Transfer the current ownership of this registry record to a new owner
    function record_ownership_transfer(
        bytes32 record_id,
        address new_owner
    )
        public
        record_in_state(record_id, RecordStates.ACTIVE)
        returns (bool valid)
    {
        // Keep track of current owner
        address prev_owner = records[record_id].owner;

        // Transfer record ownership to new owner
        records[record_id].owner = new_owner;

        // Emit relevant contract events
        emit record_ownership_transfer_history(
            record_id,
            prev_owner,
            new_owner
        );
        return true;
    }

    function record_does_exist(
        bytes32 record_id
    ) public view returns (bool exist) {
        exist = (records[record_id].state != RecordStates.NON_EXISTING);
    }

    function record_get_owner(
        bytes32 record_id
    ) public view returns (address record_owner) {
        record_owner = records[record_id].owner;
    }

    function record_get_state(
        bytes32 record_id
    ) public view returns (uint8 state) {
        state = uint8(records[record_id].state);
    }

    function record_get_attrs(
        bytes32 record_id
    ) public view returns (uint quality, uint weight) {
        quality = records[record_id].attrs.quality;
        weight = records[record_id].attrs.weight;
    }

    // ========== MODIFIERS ==========

    // Only proceed if record is in the given state.
    modifier record_in_state(bytes32 record_id, RecordStates state) {
        require(records[record_id].state == state);
        _;
    }

    modifier registry_admin_only() {
        require(msg.sender == registry_admin);
        _;
    }

    modifier record_owner_only(bytes32 record_id) {
        require(msg.sender == records[record_id].owner);
        _;
    }

    // ========== PRIVATE FUNCTIONS ==========

    function _record_create(
        bytes32 record_id,
        address record_owner,
        uint quality,
        uint weight
    ) private {
        records[record_id].owner = record_owner;
        records[record_id].attrs = RecordAttributes(quality, weight);
    }
}
