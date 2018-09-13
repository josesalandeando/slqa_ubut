#!/usr/bin/env bash

NAME_FUNCTION="AddNumbers"
NAMELC_FUNCTION="addNumbers"
SCRIPT_NAME="addNumbersTest.sh"
TARGET_PATH="./"
FILE_NAME="test-add-numbers"


function createUnitTest {

    export MYPWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    chmod +rwx $MYPWD/unit-test-sh.template
    chmod +rwx $MYPWD/unit-test-bats.template

    #Replace the values in the templates
    sed -e 's#NAME_FUNCTION#'$NAME_FUNCTION'#g' -e 's#NAMELC_FUNCTION#'$NAMELC_FUNCTION'#g' -e 's#SCRIPT_NAME#'$SCRIPT_NAME'#g' $MYPWD/unit-test-sh.template > $TARGET_PATH/$FILE_NAME.sh
    sed -e 's#NAMELC_FUNCTION#'$NAMELC_FUNCTION'#g' -e 's#NAME_FUNCTION#'$NAME_FUNCTION'#g' -e 's#SCRIPT_NAME#'$SCRIPT_NAME'#g' -e 's#FILE_NAME#'$FILE_NAME'#g' $MYPWD/unit-test-bats.template > $TARGET_PATH/$FILE_NAME.bats

    cp $MYPWD/$SCRIPT_NAME $MYPWD/../

    cp $MYPWD/$FILE_NAME.sh $MYPWD/../

    directory="tests"
    echo "PATH: $directory"
    echo "[INFO] Checking if path ${directory} exists"
    if [ -d ${directory} ]; then
        rm -Rf $MYPWD/../${directory}
        echo "[INFO] Path ${directory} existed and has been deleted"
    fi

    echo "[INFO] Creating path $directory "
    mkdir -p $MYPWD/../$directory

    cp $MYPWD/$SCRIPT_NAME $MYPWD/../$directory/
    cp $MYPWD/$FILE_NAME.sh $MYPWD/../$directory
    cp $MYPWD/$FILE_NAME.bats $MYPWD/../$directory

}

createUnitTest