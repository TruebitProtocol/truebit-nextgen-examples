# API task example

Open a terminal, move to the root directory where you installed the examples and execute the following "start API" command-line commands in sequence. Each command utilizes the same JSON manifest that describes our sample pet store OpenAPI server but demonstrates a different action based on the JSON input file.

## Expected results

All API calls should return

1. API Task executed with status - OK

Followed with the client request and server response.

## Prerequisites

1. Truebit CLI correctly installed; the `truebit` command works.

## POST add

1. truebit start-api truebit-nextgen-examples/api-tasks/petstore-crud/manifest.json truebit-nextgen-examples/api-tasks/petstore-crud/post.add.input.json

## GET

1. truebit start-api truebit-nextgen-examples/api-tasks/petstore-crud/manifest.json truebit-nextgen-examples/api-tasks/petstore-crud/get.input.json

## POST update

1. truebit start-api truebit-nextgen-examples/api-tasks/petstore-crud/manifest.json truebit-nextgen-examples/api-tasks/petstore-crud/post.update.input.json

## DELETE

1. truebit start-api truebit-nextgen-examples/api-tasks/petstore-crud/manifest.json truebit-nextgen-examples/api-tasks/petstore-crud/delete.input.json

