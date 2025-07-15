#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: ./run.sh <swift_file>"
    echo "Example: ./run.sh test.swift"
    exit 1
fi

SWIFT_FILE="$1"

if [ ! -f "$SWIFT_FILE" ]; then
    echo "Error: File '$SWIFT_FILE' not found"
    exit 1
fi

if [[ "$SWIFT_FILE" != *.swift ]]; then
    echo "Error: File must have .swift extension"
    exit 1
fi

echo "Running $SWIFT_FILE..."
swift "$SWIFT_FILE"