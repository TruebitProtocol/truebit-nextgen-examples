// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../BaseTBContract.sol";

/**
 * @title DemoContract
 * @dev A simplified contract demonstrating two core Truebit functionalities:
 *      1. API calls to deployed API tasks
 *      2. Execution of embedded functions
 * 
 * This contract serves as an example of how to interact with Truebit's 
 * decentralized computation network for both external API requests and 
 * custom function execution.
 */
contract DemoContract is BaseTBContract {
    
    /**
     * @dev Defines the two types of executions this contract supports
     * API_DEPLOYED: Calls to pre-deployed API tasks in the Truebit network
     * FUNCTION_EMBEDDED: Execution of embedded functions (like fibonacci calculation)
     */
    enum ExecutionType {
        API_DEPLOYED,        // For calling deployed API endpoints
        FUNCTION_EMBEDDED    // For running embedded computational functions
    }

    /**
     * @dev Stores all information about a single execution request
     * This struct tracks the entire lifecycle of a request from initiation to completion
     */
    struct ExecutionRequest {
        address requester;              // Who initiated the request
        ExecutionType executionType;    // What type of execution this is
        uint256 requestTimestamp;       // When the request was made
        bool isCompleted;              // Whether the execution finished
        uint256 completedTimestamp;     // When the execution completed
        uint8 executionStatus;         // Status code (0 = success, >0 = error)
        string callbackMessageDetails; // Additional details from execution
        string[] transcriptId;         // Execution transcripts for verification
        // Results storage
        string apiResult;              // Result from API calls (JSON string)
        uint256 functionValue;         // Numeric result from function execution
        string functionString;         // String result from function execution
    }

    // Storage mappings
    mapping(uint256 => ExecutionRequest) public executions;  // Stores all execution details
    mapping(uint256 => ExecutionType) public executionTypes; // Quick lookup for execution type
    
    /**
     * @dev Events emitted during the execution lifecycle
     * These events allow external systems to monitor execution progress
     */
    event ExecutionRequested(uint256 indexed wtExecutionId, ExecutionType executionType, address requester);
    event APIExecutionCompleted(uint256 indexed wtExecutionId, string result, uint8 status);
    event EmbeddedFunctionCompleted(uint256 indexed wtExecutionId, uint256 value, string message, uint8 status);
    event ExecutionFailed(uint256 indexed wtExecutionId, uint8 status, string errorMessage);

    /**
     * @dev Contract constructor
     * @param watchTowerAddress The address of the WatchTower contract that manages executions
     * @param sourceCode A string identifier for this contract's source code
     */
    constructor(
        address watchTowerAddress,
        string memory sourceCode
    ) BaseTBContract(watchTowerAddress, sourceCode) {}

    /**
     * @dev Initiates an API call to a deployed API task
     * 
     * This function demonstrates how to call external APIs through Truebit's network.
     * The example calls a store API to fetch order information by ID.
     * 
     * Flow:
     * 1. User calls this function with an order ID
     * 2. Request is sent to Truebit network for processing
     * 3. Network executes the API call
     * 4. Results are returned via callback
     * 
     * @param orderId The ID of the order to fetch from the store API
     * @return wtExecutionId A unique identifier to track this execution
     */
    function getApi(uint256 orderId) public returns (uint256) {
        // Prepare the payload for the API request
        // This includes all parameters needed to execute the API call
        bytes memory payload = abi.encode(
            'Your Namespace', // namespace - identifies the API collection
            'Your Taskname',      // taskname - specific API task to execute
            'GET',      // HTTP method
            '/store/order/{orderId}', // API endpoint path
            100000,     // executionTimeout - max time for execution
            false,      // async - whether to run asynchronously
            orderId     // orderId - the parameter for the API call
        );

        // Submit the execution request to the Truebit network
        uint256 wtExecutionId = _requestExecution(
            "request(namespace,taskname,method,path,executionTimeout,async,params(orderId:uint256))",
            payload,
            DOTypes.ExecutionType.API
        );

        // Initialize local tracking for this execution
        _initializeExecution(wtExecutionId, ExecutionType.API_DEPLOYED);
        emit ExecutionRequested(wtExecutionId, ExecutionType.API_DEPLOYED, msg.sender);
        
        return wtExecutionId;
    }

    /**
     * @dev Executes an embedded function (fibonacci calculation)
     * 
     * This function demonstrates how to run computational tasks on Truebit's network.
     * The example calculates fibonacci numbers and returns both the result and a message.
     * 
     * Flow:
     * 1. User calls this function with an input number
     * 2. Request is sent to Truebit network for processing
     * 3. Network executes the fibonacci function
     * 4. Results (number + string) are returned via callback
     * 
     * @param input The input number for fibonacci calculation
     * @return wtExecutionId A unique identifier to track this execution
     */
    function embeddedFunction(uint256 input) public returns (uint256) {
        // Prepare the payload for the function execution
        bytes memory payload = abi.encode(
            input,       // The input parameter for fibonacci calculation
            'YourNamespace',  // namespace - identifies the function collection
            'YourFunction'    // taskname - specific function to execute
        );

        // Submit the execution request to the Truebit network
        uint256 wtExecutionId = _requestExecution(
            "function(uint256,namespace,taskname)returnType(uint256,string)",
            payload,
            DOTypes.ExecutionType.FUNCTION
        );

        // Initialize local tracking for this execution
        _initializeExecution(wtExecutionId, ExecutionType.FUNCTION_EMBEDDED);
        emit ExecutionRequested(wtExecutionId, ExecutionType.FUNCTION_EMBEDDED, msg.sender);
        
        return wtExecutionId;
    }

    /**
     * @dev Internal function to set up tracking for a new execution
     * @param wtExecutionId The unique execution identifier from WatchTower
     * @param execType The type of execution being initialized
     */
    function _initializeExecution(uint256 wtExecutionId, ExecutionType execType) internal {
        ExecutionRequest memory execution;
        execution.requester = msg.sender;
        execution.executionType = execType;
        execution.requestTimestamp = block.timestamp;
        execution.isCompleted = false;
        
        executions[wtExecutionId] = execution;
        executionTypes[wtExecutionId] = execType;
    }

    /**
     * @dev Main callback function - receives results from Truebit network
     * 
     * This function is called by the WatchTower when an execution completes.
     * It routes the results to the appropriate handler based on execution type.
     * 
     * Flow:
     * 1. WatchTower calls this function with execution results
     * 2. Function validates the execution exists and isn't already completed
     * 3. Routes to appropriate handler based on execution type
     * 4. Updates storage and emits completion events
     * 
     * @param resultData The encoded result data from the execution
     * @param transcripts Array of execution transcripts for verification
     * @param wtExecutionId The execution identifier
     * @param status Execution status (0 = success, >0 = error)
     * @param callbackMessageDetails Additional details about the execution
     */
    function callbackTask(
        bytes calldata resultData, 
        string[] memory transcripts, 
        uint256 wtExecutionId, 
        uint8 status,
        string memory callbackMessageDetails
    ) external override onlywatchTower {
        // Validate the execution request exists
        require(executions[wtExecutionId].requester != address(0), "Execution ID not found");
        require(!executions[wtExecutionId].isCompleted, "Execution already completed");

        ExecutionType execType = executionTypes[wtExecutionId];
        
        if (status != 0) {
            // Handle execution errors
            _handleExecutionError(wtExecutionId, status, callbackMessageDetails, transcripts);
        } else {
            // Route successful executions to appropriate handlers
            if (execType == ExecutionType.API_DEPLOYED) {
                _handleAPICallback(wtExecutionId, resultData, callbackMessageDetails, transcripts);
            } else if (execType == ExecutionType.FUNCTION_EMBEDDED) {
                _handleEmbeddedFunctionCallback(wtExecutionId, resultData, callbackMessageDetails, transcripts);
            }
        }
    }

    /**
     * @dev Handles successful API execution results
     * 
     * Processes the result from an API call, stores it, and emits completion event.
     * API results are typically JSON strings containing the response data.
     * 
     * @param wtExecutionId The execution identifier
     * @param resultData Encoded result data (contains JSON string)
     * @param callbackMessageDetails Additional execution details
     * @param transcripts Execution transcripts for verification
     */
    function _handleAPICallback(
        uint256 wtExecutionId,
        bytes calldata resultData,
        string memory callbackMessageDetails,
        string[] memory transcripts
    ) internal {
        // Decode the API result (JSON string)
        (string memory apiResult) = abi.decode(resultData, (string));
        
        // Update the execution record with results
        ExecutionRequest memory execution = executions[wtExecutionId];
        execution.apiResult = apiResult;
        execution.transcriptId = transcripts;
        execution.executionStatus = 0;
        execution.callbackMessageDetails = callbackMessageDetails;
        execution.isCompleted = true;
        execution.completedTimestamp = block.timestamp;
        
        executions[wtExecutionId] = execution;
        emit APIExecutionCompleted(wtExecutionId, apiResult, 0);
    }

    /**
     * @dev Handles successful embedded function execution results
     * 
     * Processes results from embedded function execution. These functions typically
     * return both a numeric value and a string message (N8N format).
     * 
     * @param wtExecutionId The execution identifier
     * @param resultData Encoded result data (contains uint256 and string)
     * @param callbackMessageDetails Additional execution details
     * @param transcripts Execution transcripts for verification
     */
    function _handleEmbeddedFunctionCallback(
        uint256 wtExecutionId,
        bytes calldata resultData,
        string memory callbackMessageDetails,
        string[] memory transcripts
    ) internal {
        // Decode the function results (number + string)
        (uint256 functionValue, string memory functionString) = abi.decode(resultData, (uint256, string));
        
        // Update the execution record with results
        ExecutionRequest memory execution = executions[wtExecutionId];
        execution.functionValue = functionValue;
        execution.functionString = functionString;
        execution.transcriptId = transcripts;
        execution.executionStatus = 0;
        execution.callbackMessageDetails = callbackMessageDetails;
        execution.isCompleted = true;
        execution.completedTimestamp = block.timestamp;
        
        executions[wtExecutionId] = execution;
        emit EmbeddedFunctionCompleted(wtExecutionId, functionValue, functionString, 0);
    }

    /**
     * @dev Handles failed executions
     * 
     * When an execution fails, this function stores the error details
     * and marks the execution as completed with error status.
     * 
     * @param wtExecutionId The execution identifier
     * @param status Error status code
     * @param callbackMessageDetails Error details
     * @param transcripts Execution transcripts for debugging
     */
    function _handleExecutionError(
        uint256 wtExecutionId,
        uint8 status,
        string memory callbackMessageDetails,
        string[] memory transcripts
    ) internal {
        ExecutionRequest memory execution = executions[wtExecutionId];
        execution.executionStatus = status;
        execution.callbackMessageDetails = callbackMessageDetails;
        execution.transcriptId = transcripts;
        execution.isCompleted = true;
        execution.completedTimestamp = block.timestamp;
        
        executions[wtExecutionId] = execution;
        emit ExecutionFailed(wtExecutionId, status, callbackMessageDetails);
    }

    // =============================================================
    //                        GETTER FUNCTIONS
    // =============================================================
    // These functions allow users to query execution status and results

    /**
     * @dev Returns complete execution details
     * @param wtExecutionId The execution identifier to query
     * @return ExecutionRequest struct containing all execution information
     */
    function getExecution(uint256 wtExecutionId) public view returns (ExecutionRequest memory) {
        return executions[wtExecutionId];
    }

    /**
     * @dev Returns the execution type for a given execution
     * @param wtExecutionId The execution identifier to query
     * @return ExecutionType indicating whether it's API or function execution
     */
    function getExecutionType(uint256 wtExecutionId) public view returns (ExecutionType) {
        return executionTypes[wtExecutionId];
    }

    /**
     * @dev Checks if an execution has completed (successfully or with error)
     * @param wtExecutionId The execution identifier to query
     * @return bool true if execution is completed, false if still running
     */
    function isExecutionCompleted(uint256 wtExecutionId) public view returns (bool) {
        return executions[wtExecutionId].isCompleted;
    }

    /**
     * @dev Returns the result from an API execution
     * 
     * Use this function to get the JSON result from a completed API call.
     * The result typically contains the API response data.
     * 
     * @param wtExecutionId The execution identifier for the API call
     * @return string The JSON result from the API execution
     */
    function getAPIResult(uint256 wtExecutionId) public view returns (string memory) {
        require(
            executionTypes[wtExecutionId] == ExecutionType.API_DEPLOYED,
            "Not an API execution"
        );
        return executions[wtExecutionId].apiResult;
    }

    /**
     * @dev Returns the result from an embedded function execution
     * 
     * Use this function to get both the numeric and string results from
     * a completed embedded function execution (like fibonacci calculation).
     * 
     * @param wtExecutionId The execution identifier for the function call
     * @return functionValue The numeric result from the function
     * @return functionString The string message from the function
     */
    function getEmbeddedFunctionResult(uint256 wtExecutionId) public view returns (uint256, string memory) {
        require(
            executionTypes[wtExecutionId] == ExecutionType.FUNCTION_EMBEDDED, 
            "Not an embedded function execution"
        );
        return (executions[wtExecutionId].functionValue, executions[wtExecutionId].functionString);
    }
}