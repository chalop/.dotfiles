#!/bin/bash

if [ -f .env ]; then
    while IFS= read -r line; do
        if [ -n "$line" ] && ! [[ "$line" == \#* ]]; then
            set -o allexport
            eval "$line"
            set +o allexport
        fi
    done < .env
    echo "Exported env vars from .env"
else
    echo "No .env file"
fi
