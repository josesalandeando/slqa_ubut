#!/usr/bin/env bash

# Color Constansts
GREEN="\033[1;92m"
RED="\033[1;31m"
NOCOLOR='\033[0m'


#####################################################################################################################
# Function for print headers all tests and every function test
# Param $1 : text --> text for print
# Param $2 : typeHeader --> type off header (header of all unit test "", header of every script unit test "UT")

# EXAMPLES:
#
# Example 1: nameFunction="example"

#[INFO] -------------------------------------------------------
#
#[INFO]  example
#
#[INFO] -------------------------------------------------------

# Example: text="example2", typeHeader="UT"

#[INFO] -------------------------------------------------------
#
#[INFO]  ************ UNIT TESTS example2 *************
#
#[INFO] -------------------------------------------------------

#####################################################################################################################

function printHeaderUnitTest {

    text=$1
    typeHeader=$2
    echo
    echo "[INFO] -------------------------------------------------------"
    echo
    if [ "$typeHeader" = "UT" ]; then
        echo "[INFO]  ************ UNIT TESTS $text *************"
    else
        echo "[INFO]  $text"
    fi
    echo
    echo "[INFO] -------------------------------------------------------"
    echo
}

#####################################################################################################################
# Function for print header of test function
# Param $1 : nameFunction --> name of the function to print
#
# EXAMPLES:
#
# Example 1: nameFunction="example"

#[INFO] ------------- TEST FUNCTION -------------
#[INFO] ------------- example -------------

#####################################################################################################################

function printHeaderFunctionTest {

    local nameFunction=$1
    echo "[INFO] ------------- TEST FUNCTION ------------- "
    echo "[INFO] ------------- $nameFunction -------------"
    echo
}

#####################################################################################################################
# Function for print header of test case
# Param $1 : numTestCase --> number of test case
#
# EXAMPLES:
#
# Example 1: numTestCase="1"

#[INFO] ---------------------------------------------
#[INFO]               TEST CASE 1
#[INFO] ---------------------------------------------

#####################################################################################################################

function printHeaderTestCase {

        local numTestCase=$1
        echo "[INFO] ---------------------------------------------"
        echo -e "[INFO]   ${GREEN}            TEST CASE $numTestCase ${NOCOLOR}"
        echo "[INFO] ---------------------------------------------"
}

#####################################################################################################################
# Function for print header of test case
# Param $1 : nameFunction --> name of the function the we are testing
# Param $2 : inputs --> String with function test input variables
#
# EXAMPLES:
#
# Example 1: nameFunction="example"; inputs="[ A=1 B=2 C=3 ]"

#[INFO] FUNCTION INPUTS: [ A=1 B=2 C=3 ]
#[INFO] ---------------------
#[INFO]
#[INFO] ********** CALLING FUNCTION example **********
#[INFO]--------------------------------------------

#####################################################################################################################

function printHeaderCallFunction {

    local nameFunction=$1
#    echo "[INFO] ---------------------"
    echo "[INFO]"
    echo "[INFO] ********** CALLING FUNCTION $nameFunction ********** "
    echo "[INFO]"

}

#####################################################################################################################
# Function for print header of test case and function call
# Param $1 : numTestCase --> number of test case
# Param $2 : nameFunction --> name of the function the we are testing
# Param $3 : inputs --> String with function test input variables
#
# EXAMPLES:
#
# Example 1: numTestCase="1"; nameFunction="example"; inputs="[ A=1 B=2 C=3 ]"

#[INFO] ---------------------------------------------
#[INFO]               TEST CASE 1
#[INFO] ---------------------------------------------
#[INFO] FUNCTION INPUTS: [ A=1 B=2 C=3 ]
#[INFO] ---------------------
#[INFO]
#[INFO] ********** CALLING FUNCTION example **********
#[INFO]

#####################################################################################################################

function printHeaderTestCaseAndCallFunction {

    local numTestCase=$1
    local nameFunction=$2
    shift
    shift
    local inputs=("${@}")
    printHeaderTestCase "$numTestCase"
    printHeaderCallFunction "$nameFunction"
    printInputVariables "$nameFunction" "${inputs[@]}"

}

#####################################################################################################################
# Function for print footer after call function
# Param $1 : nameFunction --> name of the function the we are testing
# Param $2 : inputs --> String with function test input variables
#
# EXAMPLES:
#
# Example 1: nameFunction="example"; inputs="[ A=1 B=2 C=3 ]"

#[INFO]
#[INFO] ********** FUNCTION example HAS BEEN EXECUTED with INPUTS: [ A=1 B=2 C=3 ] **********
#[INFO]
#[INFO] ********** CHECK RESULTS example EXECUTION **********
#[INFO]

#####################################################################################################################

function printFooterCallFunction {

        local nameFunction=$1
        echo "[INFO]"
        echo "[INFO]"
        echo -e "${GREEN}[INFO] ********** CHECK RESULTS $nameFunction EXECUTION ********** "
        echo "[INFO]"
}

#####################################################################################################################
# Function for print footer after call function
# Param $1 : nameFunction --> name of the function the we are testing
#
# EXAMPLES:
#
# Example 1: nameFunction="example"

#[INFO]
#[INFO] ********** END CHECK RESULTS example EXECUTION **********
#[INFO] ---------------------

#####################################################################################################################

function printFooterResultTestCase {

    local nameFunction=$1
    echo -e "${GREEN}[INFO]"
    echo -e "[INFO] ********** END CHECK RESULTS $nameFunction EXECUTION ********** ${NOCOLOR}"
    echo -e "${NOCOLOR}[INFO] --------------------- "
    echo
    echo
}

#####################################################################################################################
# Function for print footer for all test in a function test
# Param $1 : nameFunction --> name of the function that we have tested
# Param $2 : error --> Say us if there are errors in the test
#
# EXAMPLES:
#
# Example 1: nameFunction="example" "0" // There is no error

#[INFO] ********** RESULTS UNIT TESTS OF example **********
#[INFO] FUNCTION: example HAS PASSED ALL TESTS WITH SUCCESS
#[INFO] ********** END UNIT TESTS OF example **********

# Example 1: nameFunction="example" "1" // There is ERROR

#[ERROR] ********** RESULTS UNIT TESTS OF example **********
#[ERROR] SOME TESTS OF example HAS NOT PASS YOU MUST CHECK THEM
#[ERROR] ********** END UNIT TESTS OF example **********

#####################################################################################################################

function printFooterFunctionTest {

    local nameFunction=$1
    local error=$2
    if [ "${error}" = "1" ]; then
        echo -e "${RED}[ERROR] ********** RESULTS UNIT TESTS OF $nameFunction ********** "
        echo -e "[ERROR] SOME TESTS OF $nameFunction HAS NOT PASS YOU MUST CHECK THEM "
        echo -e "${RED}[ERROR] ********** END UNIT TESTS OF $nameFunction ********** ${NOCOLOR}"
    else
        echo -e "${GREEN}[INFO] ********** RESULTS UNIT TESTS OF $nameFunction ********** "
        echo -e "${GREEN}[INFO] FUNCTION: $nameFunction HAS PASSED ALL TESTS WITH SUCCESS "
        echo -e "${GREEN}[INFO] ********** END UNIT TESTS OF $nameFunction ********** ${NOCOLOR}"
    fi
    echo
    echo
}

#####################################################################################################################
# Function for print footer all unit tests
# Param $1 : errorTests --> There are error in the tests
#
# EXAMPLES:
#
# Example 1: errorTests="0" //There is no error

#[INFO] -------------------------------------------------------
#
#[INFO]  ALL UNIT TESTS PASS WITH SUCCES
#
#[INFO] -------------------------------------------------------

# Example 1: errorTests="1" //There is ERROR

#[ERROR] -------------------------------------------------------
#
#[ERROR]  SOME TEST HAVE FAILED CHECK THEM
#
#[ERROR] -------------------------------------------------------

#####################################################################################################################

function printFooterAllTests {

    local errorTests=$1
    if [ "$errorTests" = "1" ]; then
        printFooterAllTestsWithFails
    else
        printFooterAllTestsWithSuccess
    fi
}

#####################################################################################################################
# Function for print footer all unit tests when there are errors
#
# EXAMPLES:
#

#[ERROR] -------------------------------------------------------
#
#[ERROR]  SOME TEST HAVE FAILED CHECK THEM
#
#[ERROR] -------------------------------------------------------

#####################################################################################################################

function printFooterAllTestsWithFails {

    echo
    echo -e "${RED}[ERROR] -------------------------------------------------------"
    echo
    echo "[ERROR]  SOME TEST HAVE FAILED CHECK THEM"
    echo
    echo -e "[ERROR] ------------------------------------------------------- ${NOCOLOR}"
    echo
}

#####################################################################################################################
# Function for print footer all unit tests when there are errors
#
# EXAMPLES:
#

#[INFO] -------------------------------------------------------
#
#[INFO]  ALL UNIT TESTS PASS WITH SUCCES
#
#[INFO] -------------------------------------------------------

#####################################################################################################################

function printFooterAllTestsWithSuccess {

    echo
    echo -e "${GREEN}[INFO] -------------------------------------------------------"
    echo
    echo "[INFO]  ALL UNIT TESTS PASS WITH SUCCES"
    echo
    echo -e "[INFO] ------------------------------------------------------- ${NOCOLOR}"
    echo
}

#####################################################################################################################
# Function for print footer all unit tests depends on their errors
#
# EXAMPLES:
#
# Example 1: FUNCTION_NAME="example"; ERROR_UNIT_TEST_FUNCTION="0"  //There is no error

#[INFO] ********** RESULTS UNIT TESTS OF example **********
#[INFO] FUNCTION: example HAS PASSED ALL TESTS WITH SUCCESS
#[INFO] ********** END UNIT TESTS OF example **********

# Example 2: FUNCTION_NAME="example"; ERROR_UNIT_TEST_FUNCTION="1"  //There is ERROR

#[ERROR] ********** RESULTS UNIT TESTS OF example **********
#[ERROR] SOME TESTS OF example HAS NOT PASS YOU MUST CHECK THEM
#[ERROR] ********** END UNIT TESTS OF example **********

#####################################################################################################################

function printFooterFunctionTestCheckingErrors {

    local FUNCTION_NAME=$1
    local ERROR_UNIT_TEST_FUNCTION=$2
    printFooterFunctionTest "$FUNCTION_NAME" "$ERROR_UNIT_TEST_FUNCTION"
    if [ "$ERROR_UNIT_TEST_FUNCTION" = "0" ]; then
        return
    else
        if [ "$ERROR_UNIT_TEST_FUNCTION" = "1" ]; then
            return 1
        fi

    fi
}

#####################################################################################################################
# Function for print inputs variables
# Param $1 : nameFunction --> nameFunction
# Param $2 : listVariables --> list of variables for print
# EXAMPLES:
#
# Example 1: FUNCTION_NAME="example"; ERROR_UNIT_TEST_FUNCTION="0"  //There is no error

#[INFO] ********** RESULTS UNIT TESTS OF example **********
#[INFO] FUNCTION: example HAS PASSED ALL TESTS WITH SUCCESS
#[INFO] ********** END UNIT TESTS OF example **********

# Example 2: FUNCTION_NAME="example"; ERROR_UNIT_TEST_FUNCTION="1"  //There is ERROR

#[ERROR] ********** RESULTS UNIT TESTS OF example **********
#[ERROR] SOME TESTS OF example HAS NOT PASS YOU MUST CHECK THEM
#[ERROR] ********** END UNIT TESTS OF example **********

#####################################################################################################################

function printInputVariables {

    local nameFunction=$1
    shift
    local listVariables=("${@}")
    INPUT_VARIABLES="[ "
    for variable in ${listVariables[@]}; do
        INPUT_VARIABLES+="$variable=${!variable}; "
    done
    INPUT_VARIABLES+="]"
    echo "[INFO] *********************************************************"
    echo "[INFO] ------------------- INPUTS $nameFunction ---------------------"
    echo "[INFO] *********************************************************"
    echo "[INFO]"
    echo "[INFO] FUNCTION INPUTS: $INPUT_VARIABLES"
    echo "[INFO]"
    echo "[INFO] *********************************************************"
    echo "[INFO] ----------------------- END INPUTS ----------------------"
    echo "[INFO] *********************************************************"

}

function printMessageError {
    local message=$1
    echo -e "${RED}[ERROR] $message ${NOCOLOR}"
}