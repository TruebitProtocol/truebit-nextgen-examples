import * as fs from 'fs';
import * as std from 'std';

// Fibonacci using BigInt: no upper-bound on fibonacci number
function fibonacci(n) {
  if (n === 0) {
    return 0n;
  } else if (n === 1) {
    return 1n;
  }

  let a = 0n;
  let b = 1n;
  let c = 0n;

  for (let i = 2; i <= n; i++) {
    c = a + b;
    a = b;
    b = c;
  }

  return c;
}

function main() {
  let input;
  try {
    input = fs.readFileSync('input.txt', 'utf8');
  } catch(e) {
    std.err.puts('Cannot read from input: ' + e);
    std.exit(1);
  }

  const n = parseInt(input);

  if (isNaN(n) || n < 0) {
    std.err.puts('Invalid input; must be a non-negative integer');
    std.exit(1);
  }

  // BigInt to String
  const output = fibonacci(n).toString();

  try {
    fs.writeFileSync('output.txt', output);
  } catch(e) {
    std.err.puts('Cannot write to output: ' + e);
    std.exit(1);
  }
}

main();
