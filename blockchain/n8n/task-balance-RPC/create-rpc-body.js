import { writeFileSync, readFileSync } from 'fs';
import { keccak256 } from '@ethersproject/keccak256';
import { toUtf8Bytes } from '@ethersproject/strings';

function validateAddress(address) {
  // Remove 0x prefix if present
  const cleanAddress = address.replace(/^0x/, '');

  // Validate address length
  if (cleanAddress.length !== 40) {
    throw new Error(`Invalid address length: ${address}. Expected 40 hex characters.`);
  }

  // Validate hex characters
  if (!/^[0-9a-fA-F]+$/.test(cleanAddress)) {
    throw new Error(`Invalid address format: ${address}. Must contain only hex characters.`);
  }

  return cleanAddress.toLowerCase();
}

function generateFunctionSelector(functionSignature) {
  // Generate function selector by taking first 4 bytes of keccak256 hash
  const hash = keccak256(toUtf8Bytes(functionSignature));
  return hash.slice(2, 10); // Remove 0x prefix and take first 4 bytes (8 hex chars)
}

function encodeAddress(address) {
  const cleanAddress = validateAddress(address);
  // Pad address to 32 bytes (64 hex chars)
  const padding = '000000000000000000000000';
  return padding + cleanAddress;
}

function encodeGenericFunctionData(functionName, paramTypes, paramValues) {
  // Validate input lengths match
  if (paramTypes.length !== paramValues.length) {
    throw new Error('Parameter types and values length mismatch');
  }

  // Create function signature
  const functionSignature = `${functionName}(${paramTypes.join(',')})`;
  console.log('Function signature:', functionSignature);

  // Generate function selector
  const functionSelector = generateFunctionSelector(functionSignature);
  console.log('Function selector:', functionSelector);

  // Encode parameters
  let encodedParams = '';

  for (let i = 0; i < paramTypes.length; i++) {
    const paramType = paramTypes[i];
    const paramValue = paramValues[i];

    if (paramType === 'address') {
      encodedParams += encodeAddress(paramValue);
    } else if (paramType.startsWith('uint')) {
      // Handle all uint types (uint8, uint16, uint32, uint256, etc.)
      const hexValue = BigInt(paramValue).toString(16).padStart(64, '0');
      encodedParams += hexValue;
    } else {
      throw new Error(`Unsupported parameter type: ${paramType}`);
    }
  }

  // Combine selector and encoded parameters
  const encodedData = '0x' + functionSelector + encodedParams;
  return encodedData;
}

function createRpcRequestBody(input) {
  const body = JSON.parse(input);

  // Extract parameters from input
  const contractAddress = body.contractAddress || body[0]?.contractAddress;
  const functionName = body.functionName || body[0]?.functionName || 'balanceOf';
  const paramTypes = body.paramTypes || body[0]?.paramTypes || ['address'];
  const paramValues = body.paramValues || body[0]?.paramValues;
  const rpcId = body.rpcId || body[0]?.rpcId || 1;

  // Validate required inputs
  if (!contractAddress) {
    throw new Error('Contract address is required');
  }

  if (!paramValues || paramValues.length === 0) {
    throw new Error('Parameter values are required');
  }

  console.log('Creating RPC request for:');
  console.log('Contract:', contractAddress);
  console.log('Function:', functionName);
  console.log('Param Types:', paramTypes);
  console.log('Param Values:', paramValues);

  // Generate the encoded data for the function call
  const encodedData = encodeGenericFunctionData(functionName, paramTypes, paramValues);

  // Create the JSON-RPC request body
  const requestBody = {
    jsonrpc: '2.0',
    method: 'eth_call',
    params: [
      {
        to: contractAddress,
        data: encodedData,
      },
      'latest',
    ],
    id: rpcId,
  };

  return JSON.stringify(requestBody);
}

// Read input from input.txt, process it, and write to output.txt
const data = readFileSync('input.txt', 'utf8');
const output = createRpcRequestBody(data);
writeFileSync('output.txt', output);
