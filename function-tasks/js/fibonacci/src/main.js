const fs = require('fs');

function fibonacci(n) {
  if (n === 0) {
    return 0;
  } else if (n === 1) {
    return 1;
  }

  let a = 0;
  let b = 1;
  let c = 0;

  for (let i = 2; i <= n; i++) {
    c = a + b;
    a = b;
    b = c;
  }

  return c;
}

function runTask(input) {
  return fibonacci(parseInt(input)).toString();
}

let data = fs.readFileSync('input.txt', 'utf8');
const output = runTask(data);
fs.writeFileSync('output.txt', output);
