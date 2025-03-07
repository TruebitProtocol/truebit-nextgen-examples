# SHA-256 hash using the Deno webcrypto library

This example demonstrates how to calculate a SHA-256 hash using the webcrypto facilities embedded in the Deno framework. It is included in the task as a native ES6 module. This is the most performant way to use crypto functions, since the Deno webcrypto library is compiled as an extension of the Javascript interpreter.

# Build and Start the example task

Open a terminal, move to the root directory where you installed the examples and execute the following Build and Start command-line commands in sequence:

## Prerequisites

1. Truebit CLI correctly installed; the `truebit` command works.

## Build command

1. truebit build truebit-nextgen-examples/function-tasks/js/sha256-deno -l js

## Build results

You'll get a [TaskId] to use with the Start command.

## Start command

1. truebit start [TaskId] "some message to hash"

## Task result

490fd35f15fe3a70721a33f8fe0e7cfddb5c98d0c179c33587fcdd5b4baeea77

