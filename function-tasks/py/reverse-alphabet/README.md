# Build and Start the example task

Open a terminal, move to the root directory where you installed the examples and execute the following Build and Start command-line commands in sequence:

## Prerequisites

1. Truebit CLI correctly installed; the `truebit` command works.

## Build command

1. truebit build truebit-nextgen-examples/function-tasks/py/reverse-alphabet/src -l py

## Build results

You'll get a [TaskId] to use with the Start command.

## Start command

1. truebit start [TaskId] "abcdefghijk"

## Task result

kjihgfedcba
