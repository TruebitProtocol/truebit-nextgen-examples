// SPDX-License-Identifier: MIT
// Types.sol — shared enums and structs for Dynamic Oracle system
pragma solidity ^0.8.0;

library DOTypes {
    /// @notice supported execution types
    enum ExecutionType {
        EMBEDDED_FUNCTION,
        EMBEDDED_API,
        FUNCTION,
        API
    }

    /// @notice callback status
    enum ExecutionStatus {
        SUCCESS, //same result all nodes 
        FAILED, // indeterminate or mismatch between nodes
        ERROR, // verified error
        EXCEEDED, // Gas limit exceeded
        CODE_HASH_MISMATCH // code hash mismatch
    }

    /// @notice struct for execution request
    struct ExecutionRequest {
        string methodSignature;
        bytes  input;
        bytes32 codeHash;
        ExecutionType executionType;
    }
}
