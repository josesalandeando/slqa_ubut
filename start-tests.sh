#!/usr/bin/env bash

if [ "${MODE_TESTS}" = "VERBOSE" ]; then
    if [ ! "${SCRIPT_TEST}" = "" ]; then
        chmod +x ${SCRIPT_TEST}
        source ${SCRIPT_TEST}
    else
        source example-unit-test.sh
    fi
else
    BATS_SCRIPT_RUN="example-unit-test.bats"
    if [ ! "${SCRIPT_TEST}" = "" ]; then
        BATS_SCRIPT_RUN=${SCRIPT_TEST}
    fi
    cd /batsTest/bin/
    ./bats /${BATS_SCRIPT_RUN}
fi
