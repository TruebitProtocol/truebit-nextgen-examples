import require$$0 from 'fs';

function getDefaultExportFromCjs (x) {
	return x && x.__esModule && Object.prototype.hasOwnProperty.call(x, 'default') ? x['default'] : x;
}

var main$1 = {};

var hasRequiredMain;

function requireMain () {
	if (hasRequiredMain) return main$1;
	hasRequiredMain = 1;
	const fs = require$$0;

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
	return main$1;
}

var mainExports = requireMain();
var main = /*@__PURE__*/getDefaultExportFromCjs(mainExports);

export { main as default };
