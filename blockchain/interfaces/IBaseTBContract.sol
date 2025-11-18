// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBaseTBContract {
    function getTaskSource() external view returns (string memory);
    function callbackTask(
        bytes calldata resultData, 
        string[] memory transcripts, 
        uint256 wtExecutionId, 
        uint8 status,
        string memory callbackMessageDetails
    ) external;
}