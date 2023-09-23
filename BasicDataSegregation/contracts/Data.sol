// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Data {
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

    address public logicContract;
    address public owner;

    modifier onlyLogic() {
        require(
            msg.sender == logicContract,
            "Only the logic contract can call this function."
        );
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    constructor() {
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
    }

    function setLogicContract(address _logicContract) external onlyOwner {
        logicContract = _logicContract;
    }

    function getLogicContract() external view returns (address) {
        return logicContract;
    }

    function setConsignmentWeight(uint _consignmentWeight) external onlyLogic {
        consignmentWeight = _consignmentWeight;
    }

    function getConsignmentWeight() external view returns (uint) {
        return consignmentWeight;
    }

    function setIsLoanAccepted(bool _isLoanAccepted) external onlyLogic {
        isLoanAccepted = _isLoanAccepted;
    }

    function getIsLoanAccepted() external view returns (bool) {
        return isLoanAccepted;
    }

    function setTitleCreationSuccess(
        bool _titleCreationSuccess
    ) external onlyLogic {
        titleCreationSuccess = _titleCreationSuccess;
    }

    function getTitleCreationSuccess() external view returns (bool) {
        return titleCreationSuccess;
    }

    function setIsDirectSale(bool _isDirectSale) external onlyLogic {
        isDirectSale = _isDirectSale;
    }

    function getIsDirectSale() external view returns (bool) {
        return isDirectSale;
    }

    function setTitleId(bytes32 _titleId) external onlyLogic {
        titleId = _titleId;
    }

    function getTitleId() external view returns (bytes32) {
        return titleId;
    }

    function setTitleTransferSuccess(
        bool _titleTransferSuccess
    ) external onlyLogic {
        titleTransferSuccess = _titleTransferSuccess;
    }

    function getTitleTransferSuccess() external view returns (bool) {
        return titleTransferSuccess;
    }

    function setTruckWeightWithoutConsignment(
        uint _truckWeightWithoutConsignment
    ) external onlyLogic {
        truckWeightWithoutConsignment = _truckWeightWithoutConsignment;
    }

    function getTruckWeightWithoutConsignment() external view returns (uint) {
        return truckWeightWithoutConsignment;
    }

    function setBuyer(address _buyer) external onlyLogic {
        buyer = _buyer;
    }

    function getBuyer() external view returns (address) {
        return buyer;
    }

    function setTruckWeightWithConsignment(
        uint _truckWeightWithConsignment
    ) external onlyLogic {
        truckWeightWithConsignment = _truckWeightWithConsignment;
    }

    function getTruckWeightWithConsignment() external view returns (uint) {
        return truckWeightWithConsignment;
    }

    function setGrainQuality(uint _grainQuality) external onlyLogic {
        grainQuality = _grainQuality;
    }

    function getGrainQuality() external view returns (uint) {
        return grainQuality;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}
