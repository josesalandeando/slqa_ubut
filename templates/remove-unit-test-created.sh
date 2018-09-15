#!/usr/bin/env bash


SCRIPT_NAME="addNumbersTest.sh"
TEST_SCRIPT_NAME="test-add-numbers"
TESTS_PATH="tests"

function removeUnitTestCreated {

    export MYPWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    echo "[INFO] Deleting folder $MYPWD/../$SCRIPT_NAME"
    rm -Rf $MYPWD/../$SCRIPT_NAME
    echo "[INFO] $MYPWD/../$SCRIPT_NAME deleted"

    echo "[INFO] Deleting folder $MYPWD/../$TEST_SCRIPT_NAME.sh"
    rm -Rf $MYPWD/../$TEST_SCRIPT_NAME.sh
    echo "[INFO] $MYPWD/../$TEST_SCRIPT_NAME..sh deleted"

    echo "[INFO] Deleting folder $MYPWD/../$TESTS_PATH"
    rm -Rf $MYPWD/../$TESTS_PATH
    echo "[INFO] $MYPWD/../$TESTS_PATH deleted"

}

removeUnitTestCreated