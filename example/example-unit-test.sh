#!/usr/bin/env bash

ERROR_RUN_TEST=0

dirActual="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $dirActual/example.sh
source $dirActual/utils-print.sh
source $dirActual/utils-test.sh


function prepareGlobalInputForTestCaseAddNumbers {

    createFile "$FILENAME" "$FILEPATH"
}

function cleanScenarioAfterExecuteAllTestsAddNumbers {

    deleteDirectory "$FILE"

}

function printResultTestAddNumbers {

#   Testing if a expression appears in file
    if [ ! "$ERROR_EXPECTED" = "Y" ]; then
        checkAppearsInFile "RES: $RESULT" "$FILE" "-F"
        checkIfErrorTestCase "$ERROR_UNIT_TEST_FUNCTION" "$?"
        ERROR_UNIT_TEST_FUNCTION=$?
    fi

#   Testing if function result (var RESULT) is equal to result expected
    checkIfResultExpected "$RESULT" "$RESULT_EXPECTED" "$ERROR_EXPECTED"
    checkIfErrorTestCase "$ERROR_UNIT_TEST_FUNCTION" "$?"
    ERROR_UNIT_TEST_FUNCTION=$?

}

ERROR_UNIT_TEST_FUNCTION=0
FUNCTION_NAME="addNumbers"
#   *************** FUNCTION INPUT GLOBAL FOR ALL TEST **********************
FILEPATH=./
FILENAME=resultAdd.txt
FILE=${FILEPATH}${FILENAME}
#   *************** FUNCTION INPUT FOR EVERY TEST CASE **********************
NUMBER_ONE=""
NUMBER_TWO=""
RESULT=""
INPUT_VARIABLES_FUNCTION=("NUMBER_ONE" "NUMBER_TWO" "RESULT")
#   *************** TEST CASE COUNT **********************
let numTestCase=1

function testAddNumbers {

#   *************** Print header of the function **********************
    printHeaderFunctionTest "$FUNCTION_NAME"
    prepareGlobalInputForTestCaseAddNumbers


#    TEST CASE 1 HAPPY PATH: Two parameters are numbers and exist file

#   *************** FUNCTION INPUT **********************
    NUMBER_ONE="174"
    NUMBER_TWO="75"
    RESULT=""
#   *************** PRINTS INPUT AND HEADER TEST **********************
    printHeaderTestCaseAndCallFunction "$numTestCase" "$FUNCTION_NAME" "${INPUT_VARIABLES_FUNCTION[@]}"
#   *************** EXECUTE FUNCTION **********************
    addNumbers "$NUMBER_ONE" "$NUMBER_TWO" "RESULT" "$FILE"
    RESULT_EXPECTED=249
    ERROR_EXPECTED="N"
#   *************** PRINTS RESULT TEST **********************
    printFooterCallFunction "$FUNCTION_NAME"
    printResultTestAddNumbers
    printFooterResultTestCase "$FUNCTION_NAME"

#   *************** INCREMENTS NUM TEST CASE **********************
    numTestCase=$(($numTestCase+1))


#    TEST CASE 2 ERROR PATH: The first parameter is a letter

    NUMBER_ONE="a"
    NUMBER_TWO="321"
    RESULT=""
    printHeaderTestCaseAndCallFunction "$numTestCase" "$FUNCTION_NAME" "${INPUT_VARIABLES_FUNCTION[@]}"
#   This is by the use of bats, when a function exit it has problems and they are solved this
    local EXECUTION_ERROR=$(echo $(addNumbers "$NUMBER_ONE" "$NUMBER_TWO" "RESULT" "$FILE"))
    RESULT_EXPECTED=
    ERROR_EXPECTED="Y"
    printFooterCallFunction "$FUNCTION_NAME"
    printResultTestAddNumbers
    printFooterResultTestCase "$FUNCTION_NAME"
    numTestCase=$(($numTestCase+1))


#    TEST CASE 3 ERROR PATH: The second parameter is a letter

    NUMBER_ONE="293"
    NUMBER_TWO="b"
    RESULT=""
    printHeaderTestCaseAndCallFunction "$numTestCase" "$FUNCTION_NAME" "${INPUT_VARIABLES_FUNCTION[@]}"
#    addNumbers "$NUMBER_ONE" "$NUMBER_TWO" "RESULT" "$FILE"
    EXECUTION_ERROR=$(echo $(addNumbers "$NUMBER_ONE" "$NUMBER_TWO" "RESULT" "$FILE"))
    RESULT_EXPECTED=
    ERROR_EXPECTED="Y"
    printFooterCallFunction "$FUNCTION_NAME"
    printResultTestAddNumbers
    printFooterResultTestCase "$FUNCTION_NAME"
    numTestCase=$(($numTestCase+1))


#    TEST CASE 4 ERROR PATH: Two parameters are numbers and NOT exist file

    NUMBER_ONE="157"
    NUMBER_TWO="326"
    RESULT=""
    printHeaderTestCaseAndCallFunction "$numTestCase" "$FUNCTION_NAME" "${INPUT_VARIABLES_FUNCTION[@]}"
#    addNumbers "$NUMBER_ONE" "$NUMBER_TWO" "RESULT" "A_File_that_NOT_exists"
    EXECUTION_ERROR=$(echo $(addNumbers "$NUMBER_ONE" "$NUMBER_TWO" "RESULT" "A_File_that_NOT_exists"))
    RESULT_EXPECTED=
    ERROR_EXPECTED="Y"
    printFooterCallFunction "$FUNCTION_NAME"
    printResultTestAddNumbers
    printFooterResultTestCase "$FUNCTION_NAME"
    numTestCase=$(($numTestCase+1))


#   *************** END TEST CASES **********************

#   *************** CLEAN SPECIFIC INPUTS **********************
    cleanScenarioAfterExecuteAllTestsAddNumbers

#   *************** CLEAN SPECIFIC INPUTS **********************
    printFooterFunctionTestCheckingErrors "$FUNCTION_NAME" "$ERROR_UNIT_TEST_FUNCTION"

}

printHeaderUnitTest "example.sh" "UT"
testAddNumbers
checkIfErrorTestCase "$ERROR_RUN_TEST" "$?"
ERROR_RUN_TEST=$?

return "$ERROR_RUN_TEST"