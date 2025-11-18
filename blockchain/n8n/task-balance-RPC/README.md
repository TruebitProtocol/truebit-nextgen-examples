# Generic Contract Function Caller - RPC Body Creator Task

This is a generic Truebit task that creates JSON-RPC request bodies for calling any smart contract function. It dynamically generates function selectors and encodes parameters for `eth_call` requests.

## Overview

This task takes a contract address, function name, parameter types, and parameter values from `input.txt` and generates a properly formatted JSON-RPC request body that can be used with any RPC endpoint.

## Input Format

Create an `input.txt` file with the following JSON structure:

### Example 1: stakingOf(address, address)

```json
{
  "contractAddress": "0xA0b86a33E6417876C6FDC6dbe3a1A82e915f5eD8",
  "functionName": "stakingOf",
  "paramTypes": ["address", "address"],
  "paramValues": ["0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045", "0x1111111111111111111111111111111111111111"],
  "rpcId": 1
}
```

### Example 2: balanceOf(address)

```json
{
  "contractAddress": "0xA0b86a33E6417876C6FDC6dbe3a1A82e915f5eD8",
  "functionName": "balanceOf",
  "paramTypes": ["address"],
  "paramValues": ["0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045"],
  "rpcId": 1
}
```

### Example 3: allowance(address, address)

```json
{
  "contractAddress": "0x1234567890123456789012345678901234567890",
  "functionName": "allowance",
  "paramTypes": ["address", "address"],
  "paramValues": ["0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045", "0x1111111111111111111111111111111111111111"],
  "rpcId": 1
}
```

### Example 4: Mixed Parameters getStakeInfo(address, uint256)

```json
{
  "contractAddress": "0x5678901234567890123456789012345678901234",
  "functionName": "getStakeInfo",
  "paramTypes": ["address", "uint256"],
  "paramValues": ["0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045", "123456"],
  "rpcId": 1
}
```

## Supported Parameter Types

- `address` - Ethereum addresses (20 bytes)
- `uint256` - 256-bit unsigned integers
- `uint8`, `uint16`, `uint32`, etc. - Other unsigned integer types

## Output

The task outputs a JSON-RPC request body to `output.txt`:

### Example Output for stakingOf(address, address):

```json
{
  "jsonrpc": "2.0",
  "method": "eth_call",
  "params": [
    {
      "to": "0xA0b86a33E6417876C6FDC6dbe3a1A82e915f5eD8",
      "data": "0x[function_selector][encoded_param1][encoded_param2]"
    },
    "latest"
  ],
  "id": 1
}
```

## Building and Running

### 1. Install Dependencies

```bash
npm install
```

### 2. Build with Rollup

```bash
npx rollup -c
```

This creates a bundled version in `dist/create-rpc-body.js`.

### 3. Test Locally

```bash
# Make sure input.txt exists with valid data
npm test
# or
node create-rpc-body.js
```

## What it Does

1. **Reads** contract address, function name, parameter types, and values from `input.txt`
2. **Generates** function selector by hashing the function signature
3. **Validates** and encodes parameters according to their types
4. **Creates** JSON-RPC request body with `eth_call` method
5. **Writes** the result to `output.txt`

### Function Selector Generation

- Creates function signature: `functionName(param1Type,param2Type)`
- Computes keccak256 hash of the signature
- Takes first 4 bytes as the function selector

### Parameter Encoding

- **address**: Validates format, pads to 32 bytes
- **uint256/uint**: Converts to hex, pads to 32 bytes
- Parameters are concatenated in order

## Real-world Examples

### Staking Contract

```json
{
  "contractAddress": "0x...",
  "functionName": "stakingOf",
  "paramTypes": ["address", "address"],
  "paramValues": ["0xStaker...", "0xValidator..."]
}
```

### ERC20 Token

```json
{
  "contractAddress": "0x...",
  "functionName": "balanceOf",
  "paramTypes": ["address"],
  "paramValues": ["0xWallet..."]
}
```

### Custom Contract

```json
{
  "contractAddress": "0x...",
  "functionName": "getUserStake",
  "paramTypes": ["address", "uint256"],
  "paramValues": ["0xUser...", "1000"]
}
```

## Integration with API Task

The output from this task can be used as input for any RPC API task:

1. **This Task** → creates RPC request body for any contract function
2. **API Task** → uses the request body to call the RPC endpoint
3. **Encoding Task** → processes the API response

## Example Input Files

The project includes several example input files:

- `input.txt` - stakingOf(address, address) example
- `input.balanceOf.example.txt` - balanceOf(address) example
- `input.allowance.example.txt` - allowance(address, address) example
- `input.mixed-params.example.txt` - getStakeInfo(address, uint256) example

## Popular Use Cases

### ERC20 Functions

- `balanceOf(address)` - Get token balance
- `allowance(address,address)` - Get spending allowance
- `totalSupply()` - Get total token supply (no parameters)

### Staking Contracts

- `stakingOf(address,address)` - Get staking amount
- `getStakeInfo(address,uint256)` - Get stake details
- `isValidator(address)` - Check validator status

### NFT Contracts

- `ownerOf(uint256)` - Get NFT owner
- `balanceOf(address)` - Get NFT count
- `tokenOfOwnerByIndex(address,uint256)` - Get token by index
