// rollup.config.js

import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';

export default {
  input: 'main.js',
  output: {
    file: 'dist/main.js',
    name: 'MyBundle', // global variable name (if needed)
  },
  plugins: [resolve({ browser: true, preferBuiltins: false }), commonjs()],
};
