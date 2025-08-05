import { defaultAbiCoder } from  '@ethersproject/abi';
import { writeFileSync, readFileSync } from 'fs';
function create(res) {
  
  const body = JSON.parse(res);
  const values = [body[0].id, body[0].name];
  const types = ['uint256', 'string'];
  const encodedInput = defaultAbiCoder.encode(types, values);
  return encodedInput.toString();
}
const data = readFileSync('input.txt', 'utf8');
const output = create(data);
writeFileSync('output.txt', output);

