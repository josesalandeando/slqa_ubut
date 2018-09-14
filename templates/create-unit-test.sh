#!/usr/bin/env bash

NAME_FUNCTION="addNumbers"
FCL_NAME_FUNCTION=$(echo "$NAME_FUNCTION" | sed 's/^./\u&/')
SCRIPT_NAME="addNumbersTest.sh"
TARGET_PATH="./"
TEST_SCRIPT_NAME="test-add-numbers"
TESTS_PATH="tests"


function createUnitTest {

    export MYPWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    chmod +rwx $MYPWD/unit-test-sh.template
    chmod +rwx $MYPWD/unit-test-bats.template


    TESTS_PATH="tests"
    echo "PATH: $TESTS_PATH"
    echo "[INFO] Checking if path ${TESTS_PATH} exists"
    if [ -d $MYPWD/../${TESTS_PATH} ]; then
        rm -Rf $MYPWD/../${TESTS_PATH}
        echo "[INFO] Path ${TESTS_PATH} existed and has been deleted"
    fi
    echo "[INFO] Creating path $TESTS_PATH "
    mkdir -p $MYPWD/../$TESTS_PATH


    #Replace the values in the templates
    sed -e 's#FCL_NAME_FUNCTION#'$FCL_NAME_FUNCTION'#g' -e 's#NAME_FUNCTION#'$NAME_FUNCTION'#g' -e 's#SCRIPT_NAME#'$SCRIPT_NAME'#g' $MYPWD/unit-test-sh.template > $MYPWD/../$TEST_SCRIPT_NAME.sh
    sed -e 's#FCL_NAME_FUNCTION#'$FCL_NAME_FUNCTION'#g' -e 's#NAME_FUNCTION#'$NAME_FUNCTION'#g' -e 's#TEST_SCRIPT_NAME#'$TEST_SCRIPT_NAME'#g' -e 's#SCRIPT_NAME#'$SCRIPT_NAME'#g' $MYPWD/unit-test-bats.template > ../$TESTS_PATH/$TEST_SCRIPT_NAME.bats

    cp $MYPWD/$SCRIPT_NAME $MYPWD/../

    cp $MYPWD/../$SCRIPT_NAME $MYPWD/../$TESTS_PATH
    cp $MYPWD/../$TEST_SCRIPT_NAME.sh $MYPWD/../$TESTS_PATH

}


createUnitTest