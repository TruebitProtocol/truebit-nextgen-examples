# Initialize the Javascript node task

1. Open a terminal, move to this example main directory and execute the following command:
npm i

2. Invoke rollup to create a single source file that embeds used node.js libraries:
npx rollup -c

# Build and Start the example task

Open a terminal, move to the root directory where you installed the examples and execute the following Build and Start command-line commands in sequence:

## Prerequisites

1. Truebit CLI correctly installed; the `truebit` command works.

## Build command

1. truebit build truebit-nextgen-examples/function-tasks/js/fibonacci/dist -l js

## Build results

You'll get a [TaskId] to use with the Start command.

## Start command

1. truebit start [TaskId] 22

## Task result

17711

