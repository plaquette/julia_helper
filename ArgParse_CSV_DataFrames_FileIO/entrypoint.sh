#!/bin/bash

# Set JULIA_PROJECT environment variable
export JULIA_PROJECT="/env"

# If no arguments are provided, start an interactive Julia session with the specified packages loaded
if [ "$#" -eq 0 ]; then
    julia -i --eval "using Pkg; Pkg.activate(\"/env\"); using ArgParse; using CSV; using DataFrames; using FileIO;" --banner=no
else
    # Execute the provided command with arguments
    exec "$@"
fi
