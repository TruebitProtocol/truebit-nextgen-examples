// rollup.config.js

import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';

export default {
  input: 'create-rpc-body.js',
  output: {
    file: 'dist/main.js',
    name: 'BalanceRpcBodyCreator', // global variable name (if needed)
  },
  plugins: [resolve({ browser: true, preferBuiltins: false }), commonjs()],
};
