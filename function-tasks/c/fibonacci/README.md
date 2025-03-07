# C/C++ WASM toolchain installation

Open a terminal and execute the following command-line commands one by one:

1. sudo apt install wabt
2. wget https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-16/wasi-sdk-16.0-linux.tar.gz
3. tar xvf wasi-sdk-16.0-linux.tar.gz -C ${HOME}
4. echo "export WASI_SDK_PATH=${HOME}/wasi-sdk-16.0/" >> ~/.profile
5. source ~/.profile

# Build and Start the example task

Open a terminal, move to the root directory where you installed the examples and execute the following Build and Start command-line commands in sequence:

## Prerequisites

1. Truebit CLI correctly installed; the `truebit` command works.

## Build command

1. truebit build truebit-nextgen-examples/function-tasks/c/fibonacci -l c

## Build results

You'll get a [TaskId] to use with the Start command.

## Start command

1. truebit start [TaskId] 22

## Task result

17711
