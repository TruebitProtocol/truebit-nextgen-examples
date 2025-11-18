// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import '../abstract/Types.sol';
interface IWatchTower {
    event TaskRequested(
        address indexed userContract,
        address indexed userEOA,
        string methodSignature,
        bytes input,
        bytes32 codeHash,
        DOTypes.ExecutionType executionType,
        uint256 requestId
    );
    error AddressBlacklistedOrQuotaExceeded(
        address addr,
        string message
    );

    // Functions
    function requestExecution(
        string calldata methodSignature,
        bytes calldata input,
        bytes32 codeHash,
        DOTypes.ExecutionType executionType
    ) external returns (uint256);
}