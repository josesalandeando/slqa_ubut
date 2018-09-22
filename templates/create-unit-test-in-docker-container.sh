#!/usr/bin/env bash

NAME_FUNCTION="addNumbers"
FCL_NAME_FUNCTION=$(echo "$NAME_FUNCTION" | sed 's/^./\u&/')
SCRIPT_NAME="addNumbersTest.sh"
TEST_SCRIPT_NAME="test-add-numbers"


function createUnitTestInDocker {

    export MYPWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    chmod +rwx $MYPWD/unit-test-sh.template
    chmod +rwx $MYPWD/unit-test-bats.template

    #Replace the values in the templates
    sed -e 's#FCL_NAME_FUNCTION#'$FCL_NAME_FUNCTION'#g' -e 's#NAME_FUNCTION#'$NAME_FUNCTION'#g' -e 's#SCRIPT_NAME#'$SCRIPT_NAME'#g' $MYPWD/unit-test-sh.template > $MYPWD/../$TEST_SCRIPT_NAME.sh
    sed -e 's#FCL_NAME_FUNCTION#'$FCL_NAME_FUNCTION'#g' -e 's#NAME_FUNCTION#'$NAME_FUNCTION'#g' -e 's#TEST_SCRIPT_NAME#'$TEST_SCRIPT_NAME'#g' -e 's#SCRIPT_NAME#'$SCRIPT_NAME'#g' $MYPWD/unit-test-bats.template > ../$TEST_SCRIPT_NAME.bats

}


createUnitTestInDocker