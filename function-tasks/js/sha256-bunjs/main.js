import crypto from 'crypto';
import * as fs from 'fs';

function main() {
  // load message from task input
  const message = fs.readFileSync('input.txt', 'utf-8');

  // calculate message hash and output the results formatted as a hex string
  const hash = crypto.createHash('sha256');
  const result = hash.update(message).digest('hex');

  // write hash result to task output
  fs.writeFileSync('output.txt', result);

  // also print hash result to stdout
  console.log(result);
}

main();
