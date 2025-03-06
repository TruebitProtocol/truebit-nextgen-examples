# Python example using Numpy and Pandas

This example demonstrates how to utilize Numpy and Pandas within a Python function task. It also illustrates how to load a CSV data file using a TAR filesystem. When starting the task, you must specify the file path to a valid data frame located within the filesystem. Please refer to the CSV files in the included "data/" folder. The example command to start the process uses "data/frame1.csv".

# Build and Start the example task

Open a terminal, move to the Truebit CLI main directory and execute the following Build and Start command-line commands in sequence:

## Prerequisites

1. Truebit CLI correctly installed.

## Build command

1. truebit build examples/py/numpy-pandas/ -l py

## Build results

You'll get a [TaskId] to use with the Start command.

## Start command

1. truebit start [TaskId] data/frame1.csv

## Task result

A comprehensive report of several operations using the data stored in "data/frame1.csv".
