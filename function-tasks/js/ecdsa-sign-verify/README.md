# ECDSA sign verification task

This example demonstrates how to verify a ECDSA signature in a Javascript task that uses node.js. It also illustrates how to invoke the task start command passing a complex input, in this case a JSON with the message text and its signature.

# Initialize the Javascript node task

1. Open a terminal, move to this example main directory and execute the following command:
npm i

2. Invoke rollup to create a single source file that embeds used node.js libraries:
npx rollup -c

# Build and Start the example task

Move to the Truebit CLI main directory and execute the following Build and Start command-line commands in sequence:

## Prerequisites

1. Truebit CLI correctly installed.

## Build command

1. truebit build examples/js/ecdsa-sign-verify/ -l js

## Build results

You'll get a [TaskId] to use with the Start command.

## Start command

1. truebit start [TaskId] "$(examples/js/ecdsa-sign-verify/input.txt)"

## Task result

"true" if the signature is valid, "false" otherwise.

