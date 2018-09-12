#!/usr/bin/env bash

if [ "${MODE_TESTS}" = "VERBOSE" ]; then
    if [ ! "${SCRIPT_TEST}" = "" ]; then
        chmod +x ${SCRIPT_TEST}
        source ${SCRIPT_TEST}
    else
        source example-unit-test.sh
    fi
else
    SCRIPTS_TO_COPY=("example.sh" "example-unit-test.bats")
    for value in ${SCRIPTS_TO_COPY[@]}; do
        cp $value /batsTest/bin/
    done
    cd /batsTest/bin/
    ./bats /
fi
