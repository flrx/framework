#!/usr/bin/env bash

### Check if a directory does not exist ###
EXAMPLE_PATH="$MELOS_ROOT_PATH/packages/example"
if [ ! -d "$EXAMPLE_PATH" ]
then
    echo "$EXAMPLE_PATH DOES NOT exists."
    echo "Setting up example directory"
    melos setup_example
    echo "Run melos bootstrap again"
    exit 255
fi