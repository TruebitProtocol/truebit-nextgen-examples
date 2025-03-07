# Rust toolchain installation

Open a terminal and execute the following command-line commands one by one:

1. curl https://sh.rustup.rs -sSf | sh
2. source "$HOME/.cargo/env"
3. rustup default 1.78
4. rustup target add wasm32-wasip1

# Build and Start the example task

Open a terminal, move to the root directory where you installed the examples and execute the following Build and Start command-line commands in sequence:

## Prerequisites

1. Truebit CLI correctly installed; the `truebit` command works.

## Build command

1. truebit build truebit-nextgen-examples/function-tasks/rs/fibonacci -l rs

## Build results

You'll get a [TaskId] to use with the Start command.

## Start command

1. truebit start [TaskId] 22

## Task result

17711
