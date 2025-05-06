#!/bin/sh
${WASI_SDK_PATH}/bin/clang++ --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot src/main.cpp -fno-exceptions -std=c++17 -o task.wasm "-Wl,--stack-first,-zstack-size=1048576"
