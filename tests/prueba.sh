#!/usr/bin/env bash

FILES=$(ls ./)
echo "FILES: $FILES"

for file in ${FILES[@]}; do
        INPUT_VARIABLES+="$file"
        ./${file}
    done


echo "INPUT_VARIABLES:$INPUT_VARIABLES"