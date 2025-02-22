import { crypto } from 'webcrypto';
import { TextEncoder } from 'encoding';
import * as fs from 'fs';

function buf2hex(buffer) {
  return [...new Uint8Array(buffer)].map((x) => x.toString(16).padStart(2, '0')).join('');
}

async function main() {
  // load message from task input
  const message = fs.readFileSync('input.txt', 'utf-8');
  const encoder = new TextEncoder('utf-8');
  const data = encoder.encode(message).buffer;

  // calculate message hash and output the results formatted as a hex string
  const hash = await crypto.subtle.digest('sha-256', data);
  const result = buf2hex(hash);

  // write hash result to task output
  fs.writeFileSync('output.txt', Buffer.from(result.toString()));

  // also print hash result to stdout
  console.log(result);
}

main();
