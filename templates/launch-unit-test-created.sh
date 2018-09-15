#!/usr/bin/env bash

GREEN="\033[1;92m"
NOCOLOR='\033[0m'

TEST_SCRIPT_NAME="test-add-numbers"
MODE_LAUNCH="VERBOS"
IMAGE_NAME="qa-utils-bash-unit-tests"
ACTUAL_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FOLDER_IMAGE_RESOURCE=${ACTUAL_PATH}/../


function launchUnitTestCreated {

    echo -e "${GREEN}[INFO] ********** START TEST WITH LOGS ********** ${NOCOLOR}"

    source ${FOLDER_IMAGE_RESOURCE}${TEST_SCRIPT_NAME}.sh

    echo -e "${GREEN}[INFO] ********** END TEST WITH LOGS ********** ${NOCOLOR}"

    echo -e "${GREEN}[INFO] ********** BUILDING DOCKER IMAGE ********** ${NOCOLOR}"

    docker build -t ${IMAGE_NAME} ${FOLDER_IMAGE_RESOURCE}

    echo -e "${GREEN}[INFO] ********** DOCKER IMAGE HAS BEEN BUILT ********** ${NOCOLOR}"

    echo -e "${GREEN}[INFO] ********** START RUN UNIT TEST WITH BATS ********** ${NOCOLOR}"

    echo -e "${GREEN}"

    docker run -e MODE_TESTS=${MODE_LAUNCH} -e SCRIPT_TEST=${TEST_SCRIPT_NAME}.bats  ${IMAGE_NAME}

    echo -e "${NOCOLOR}"

    echo -e "${GREEN}[INFO] ********** END RUN UNIT TEST WITH BATS ********** ${NOCOLOR}"

}

launchUnitTestCreated