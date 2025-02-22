import nodeResolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import pluginJson from '@rollup/plugin-json';

export default [
    {
        input: 'src/ecdsa-verify.js',
        output: {
            file: 'dist/main.js',
            format: 'es',
            name: 'ecdsa',
        },
        plugins: [
            nodeResolve(),
            commonjs(),
            pluginJson(),
        ],
    }
]
