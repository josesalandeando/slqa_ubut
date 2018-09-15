#!/usr/bin/env bash

UTILS_PRINT="utils-print.sh"
UTILS_TEST="utils-test.sh"

function startTests {

    if [ ! "${FILE_RESOURCES_SCRIPT_TESTS}" = "" ]; then
        if [ "${MODE_TESTS}" = "VERBOSE" ]; then
            for line in $(cat $FILE_RESOURCES_SCRIPT_TESTS); do
                    echo "$line"
                    chmod +x $line
                    source $line
            done
        else
            for line in $(cat $FILE_RESOURCES_SCRIPT_TESTS); do
                testBats=""
                for f in $(cat $line); do
                    cp ./$f ./batsTest/bin/
                    if [ "${f##*.}" = "bats" ]; then
                        testBats=$f
                    fi
                done
            ./batsTest/bin/bats ./batsTest/bin/$testBats
            done
        fi
    else
#        RUN ONE TEST IN MODE "VERBOSE" (with logs)
        if [ "${MODE_TESTS}" = "VERBOSE" ]; then
            if [ ! "${SCRIPT_TEST}" = "" ]; then
                chmod +x ${SCRIPT_TEST}
                source ${SCRIPT_TEST}
            else
                source example-unit-test.sh
            fi
        else
#        RUN ONE TEST IN MODE "BATS" (with pretty print framework)
            BATS_SCRIPT_RUN="example-unit-test.bats"
            if [ ! "${SCRIPT_TEST}" = "" ]; then
                BATS_SCRIPT_RUN=${SCRIPT_TEST}
            fi
            cd /batsTest/bin/
            ./bats /${BATS_SCRIPT_RUN}
        fi
    fi

}

startTests