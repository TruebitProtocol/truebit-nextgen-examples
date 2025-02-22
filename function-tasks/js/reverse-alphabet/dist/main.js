import fs from 'fs';

function run_task(input) {
    return input.split('').reverse().join('');
}

let input = fs.readFileSync('input.txt', 'utf8');
const output = run_task(input);
fs.writeFileSync('output.txt', output);
