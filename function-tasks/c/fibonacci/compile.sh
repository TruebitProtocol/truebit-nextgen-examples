#!/bin/sh
${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot src/main.c -g -o task.wasm "-Wl,--stack-first,-zstack-size=1048576"
