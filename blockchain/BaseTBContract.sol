// SPDX-License-Identifier: MIT
// Base Contract for Dynamic Oracle
pragma solidity ^0.8.0;

import "./interfaces/IBaseTBContract.sol";
import "./interfaces/IWatchTower.sol";
import "./abstract/Types.sol";

abstract contract BaseTBContract is IBaseTBContract {
    event TruebitExecution(
        string indexed transcriptId,
        string executionStatus
    );
    event ExecutionRequested(
        uint256 indexed id
    );
    
    error AddressBlacklistedOrQuotaExceeded(address addr, string message);
    error CodeTooLarge();
    error NotwatchTower(address sender);

    modifier onlywatchTower() {
        if (msg.sender != address(watchTower)) {
            revert NotwatchTower(msg.sender);
        }
        _;
    }
    uint256 public constant MAX_CODE_LENGTH = 5 * 1024; // 5 KB
    string public _code;
    bytes32 public _codeHash;
    IWatchTower public immutable watchTower;
    constructor(address watchTowerAddress, string memory sourceCode) {
        watchTower = IWatchTower(watchTowerAddress);
        if (bytes(sourceCode).length > MAX_CODE_LENGTH) {
            revert CodeTooLarge();
        }
        _code = sourceCode;
        _codeHash = keccak256(bytes(sourceCode));
    }

    function callbackTask(
        bytes calldata resultData, 
        string[] memory transcripts, 
        uint256 wtExecutionId, 
        uint8 status,
        string memory callbackMessageDetails
    ) external virtual onlywatchTower {
    }

    function getTaskSource() external view returns (string memory) {
        return _code;
    }

    function _requestExecution(
        string memory methodSignature,
        bytes memory input,
        DOTypes.ExecutionType executionType
    ) internal returns (uint256) {
        return IWatchTower(watchTower).requestExecution(methodSignature, input, _codeHash, executionType);
    }
}
