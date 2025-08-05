import { defaultAbiCoder } from  '@ethersproject/abi';
import { writeFileSync, readFileSync } from 'fs';
function create(res) {
  
  const body = JSON.parse(res);
  const values = [body[0].id, body[0].name]; // Replace with the fields you want to encode
  const types = ['uint256', 'string']; // Match the Solidity types of the values above (same order)
  const encodedInput = defaultAbiCoder.encode(types, values);
  return encodedInput.toString();
}
const data = readFileSync('input.txt', 'utf8');
const output = create(data);
writeFileSync('output.txt', output);

