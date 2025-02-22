import nodeResolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';

export default [
  {
    input: 'src/main.js',
    output: {
      file: 'dist/main.js',
      format: 'es',
      name: 'fibonacci',
    },
    plugins: [nodeResolve(), commonjs()],
  },
];
