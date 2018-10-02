#!/usr/bin/env bash

# Color Constansts
GREEN="\033[1;92m"
RED="\033[1;31m"
NOCOLOR='\033[0m'

#####################################################################################################################
#
# Function for create a Directory (If path exists delete ir first)
# Param $1 : directory --> Path of directory to creare
#
#####################################################################################################################

function createDirectory {

    local directory=$1
    echo "[INFO] We want create path: $directory"
    echo "[INFO] Checking if path ${directory} exists"
    if [ -d ${directory} ]; then
        rm -Rf ${directory}
        echo "[INFO] Path ${directory} existed and has been deleted"
    fi

    echo "[INFO] Creating path $directory "
    mkdir -p $directory
    if [ ! -d ${directory} ]; then
        echo -e "${RED}[ERROR] Directory $directory NOT EXISTS ${NOCOLOR}"
        return 1
    fi
    echo "[INFO] Path $directory created"
    return
}

#####################################################################################################################
#
# Function for delete a path with his content
# Param $1 : directory --> Directory to delete
#
#####################################################################################################################

function deleteDirectory {

    local directory=$1
    local dirActual="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    echo -e "${GREEN}[INFO] We want delete path: $directory"
    echo -e "[INFO] Checking if path ${directory} exists ${NOCOLOR}"

    if [ -d ${directory} ]; then
        diff -rq ${directory} ${dirActual}
        if [ "$?" = "0" ]; then
            echo -e "${RED}[ERROR] SORRY YOU CAN NOT DELETE THIS PATH BECAUSE IT WOULD REMOVE ALL TESTS ${NOCOLOR}"
            return 1
        else
            rm -Rf ${directory}
            echo -e "${GREEN}[INFO] Delete file $directory after execute tests ${NOCOLOR}"
        fi
    fi

    return
}

#####################################################################################################################
#
# Function for check if there are error in a test
# Param $1 : FILE --> File name
# Param $2 : PATHFILE --> Path where file will be located
#
#####################################################################################################################

function createFile {

    local FILE=$1
    local PATHFILE=$2

    if [ "$PATHFILE" = "" ]; then
        echo "[INFO] The PATHFILE is empty we understand as PATHFILE ./"
        PATHFILE="./"
    fi

    if [ ! -d ${PATHFILE} ]; then
        echo "[INFO] Directory $PATHFILE NOT EXISTS we need create it"
        echo "[INFO] Creating path $PATHFILE "
        mkdir -p $PATHFILE
    fi

    local FOLDER_LENGTH=${#PATHFILE}
    local LAST_CHAR="${PATHFILE[@]:$(($FOLDER_LENGTH-1)):1}"

    if [ ! "$LAST_CHAR" = "/" ]; then
        echo "[INFO] Last char of $PATHFILE must be / we added this char"
        PATHFILE+=/
        echo "[INFO] Path file modified and result in $PATHFILE"
    fi

    local COMPLETE_PATH=${PATHFILE}${FILE}
    echo "[INFO] Creating file $FILE "
    echo "" > $COMPLETE_PATH

    if [ ! -e ${COMPLETE_PATH} ]; then
        echo -e "${RED}[ERROR] File ${FILE} NOT EXISTS in the path $PATHFILE ${NOCOLOR}"
        return 1
    fi
    return
}


#####################################################################################################################
#
# Function for know if a expression appears in file
# Param $1 : expression --> Expression to search
# Param $2 : pathFile --> File
# Param $2 : paramsGrep --> If you want put parameters in the grep
#
#####################################################################################################################

function checkAppearsInFile {

    local expression=$1
    local pathFile=$2
    local paramsGrep=$3
    local resultExpr=$(grep "$paramsGrep" "$expression" "$pathFile")

    if [ ! "$resultExpr" = "" ]; then
        echo -e "${GREEN}[INFO] $expression appears in the FILE $pathFile ${NOCOLOR}"
    else
        echo -e "${RED}[ERROR] $expression NOT APPEARS in the FILE $pathFile ${NOCOLOR}"
        return 1
    fi
    return

}

#####################################################################################################################
#
# Function for check if a variable appears in a file a number times
# Param $1 : NAME_VAR --> Variable name
# Param $2 : VALUE_VAR --> Variable value
# Param $3 : PATHFILE --> Path file
# Param $4 : FILENAME --> File name
# Param $5 : NUMTIMES --> Number of times that variable appears
#
#####################################################################################################################

function checkNumTimesVarInFile {

    local NAME_VAR=$1
    local VALUE_VAR=$2
    local PATHFILE=$3
    local FILENAME=$4
    local NUMTIMES=$5

    local numTimes=`grep -c $VALUE_VAR $PATHFILE`
    if [ $numTimes = $NUMTIMES ]; then
        if [ "$numTimes" = 0 ]; then
            echo "[INFO] Variable $NAME_VAR not appears in the FILE $FILENAME"
        else
            echo "[INFO] Variable $NAME_VAR appears in the FILE $FILENAME $numTimes times"
        fi
        return
    else
        echo -e "${RED}[ERROR] Variable REALM NOT APPEARS in the FILE $FILENAME $NUMTIMES times ${GREEN}"
        return 1
    fi
}

#####################################################################################################################
#
# Function for check if a file exists
# Param $1 : PATHFILE --> Complete path file
# Param $2 : FILENAME --> File name
#
#####################################################################################################################

function checkIfExistsFile {

    local PATHFILE=$1
    local FILENAME=$2
    if [ -e $PATHFILE ]; then
        echo -e "${GREEN}[INFO] File $FILENAME exists in the path $PATHFILE"
        return
    else
        echo -e "${RED}[ERROR] File $FILENAME NOT EXISTS in the path $PATHFILE ${GREEN}"
        return 1
    fi

}

#####################################################################################################################
#
# Function for check if Results are expected
# Param $1 : result --> Result function
# Param $2 : resultExpected --> Result expected
# Param $3 : errorExpect --> We expect error
# Param $4 : message --> Message to print
#
#####################################################################################################################

function checkIfResultExpected {

    local result=$1
    local resultExpected=$2
    local errorExpect=$3
    local message=$4
    local error=0

    if [ "$result" = "$resultExpected" ]; then
        if [ "$errorExpect" = "Y" ]; then
            echo -e "${GREEN}[INFO] The function HAS FAILED or EXIT as we EXPECT"
        else
            echo -e "${GREEN}[INFO] The function has executed with SUCCESS as we EXPECT"
        fi
    else
        if [ "$errorExpect" = "Y" ]; then
            echo -e "${RED}[ERROR] The function has executed with SUCCESS and we do NOT EXPECT IT ${NOCOLOR}"
        else
            echo -e "${RED}[ERROR] The function HAS FAILED and we do NOT EXPECT IT ${NOCOLOR}"
        fi
        error=1
    fi

    if [ ! "$message" = "" ]; then
        echo -e "${GREEN}[INFO] Message: $message ${NOCOLOR}"
    fi
    if [ "$error" = "1" ]; then
        return 1
    fi
    return

}

#####################################################################################################################
#
# Function for check if Results are expected
# Param $1 : PATHTEST --> Path to check if exists
# Param $2 : deleteDir --> Delete directory??
#
#####################################################################################################################

function checkIfExistsDirectory {

    local PATHTEST=$1
    local deleteDir=$2
    if [ -d ${PATHTEST} ]; then
        echo "[INFO] Directory $PATHTEST has been created"
        if [ "$deleteDir" = "Y" ]; then
            deleteDirectory "$PATHTEST"
        fi
    else
        echo -e "${RED}[ERROR] Directory $PATHTEST has NOT been created"
        return 1
    fi
    return

}

#####################################################################################################################
#
# Function for check if there are errors in one execute test
# Param $1 : previousError --> Error acumulated
# Param $2 : actualError --> Actual error
#
#####################################################################################################################

function checkIfErrorTestCase {

    local previousError=$1
    local actualError=$2
    if [ "$previousError" = "1" ]; then
        return 1
    fi
    if [ "$actualError" = "1" ]; then
        return 1
    fi
    return
}

#####################################################################################################################
#
# Function for check if a list of variables is equal to a list of values
# Param $1 : variablesNames --> List of names of variables
# Param $2 : valuesToCompare --> List of values to compare
#
#####################################################################################################################

function checkAreVariablesEquals {

    local parameters=("${@}")
    let sizeParameters=${#parameters[*]}
    let numParametersByList=$(($sizeParameters/2))
    local variablesNames=("${parameters[@]:0:$numParametersByList}")
    local valuesToCompare=("${parameters[@]:$numParametersByList:$numParametersByList}")

    if [ ! "${#variablesNames[*]}" = "${#valuesToCompare[*]}" ]; then
        echo "${RED}[ERROR] The number of variables and values for them is not the same"
        return 1
    fi

    i=0
    local error=0
    for variable in ${variablesNames[@]}; do
        if [  "${!variable}" = "${valuesToCompare[$i]}" ] ; then
            echo -e "${GREEN}[INFO] The value of $variable is ${valuesToCompare[$i]} as we expect ${NOCOLOR}"
        else
            echo -e "${RED}[ERROR] Variable $variable has as a value ${!variable} and we expect \"${valuesToCompare[$i]}\" ${NOCOLOR}"
            error=1
        fi
        i=$(($i+1))
    done

    if [ "$error" = "1" ]; then
        return 1
    fi
    return

}

#####################################################################################################################
#
# Function for check if a file has a certains credentials
# Param $1 : PATH_FILE --> File to check
# Param $2 : CREDENTIALS_EXPECTED --> Credentials to check
#
#####################################################################################################################

function checkIfFileHasCredentials {

    local PATH_FILE=$1
    local CREDENTIALS_EXPECTED=$2
    local MODEFILE=`stat -c '%a' $PATH_FILE`
    if [ "$MODEFILE" = "$CREDENTIALS_EXPECTED" ]; then
        echo -e "${GREEN}[INFO] The file $PATH_FILE has the credentials expected: "$CREDENTIALS_EXPECTED" ${NOCOLOR}"
    else
        echo -e "${RED}[ERROR] The file $PATH_FILE has NOT credentials expected: "$CREDENTIALS_EXPECTED" ${NOCOLOR}"
        return 1
    fi
    return
}

#####################################################################################################################
#
# Function for check if a list of values are in file
# Param $1 : values --> List of values to search
# Param $2 : numTimes --> Number of times variables appears
# Param $2 : fileName --> File name
#
#####################################################################################################################

function checkIfListValIsInFile {

    local parameters=("${@}")
    let sizeParameters=${#parameters[*]}
    local values=("${parameters[@]:0:$(($sizeParameters-2))}")
    local numTimes=("${parameters[@]:$(($sizeParameters-2)):1}")
    local fileName=("${parameters[@]:$(($sizeParameters-1)):1}")

#    Creating grep -e options
    local grepOptions=""
    for value in ${values[@]}; do
        grepOptions+="-e $value "
    done

    local NUMTIMES=$(grep -c ${grepOptions}  ${fileName})
    if [ "$NUMTIMES" = "$numTimes" ]; then
        if [ "$numTimes" = "0" ]; then
            echo -e "${GREEN}[INFO] The values: ${values[*]} have NOT written in the file $fileName by this not appears ${NOCOLOR}"
        else
            echo -e "${GREEN}[INFO] The values: ${values[*]} have written in the file $fileName ${NOCOLOR}"
        fi
    else
        echo -e "${RED}[ERROR] The values: ${values[*]} have NOT been written in the file $fileName ${NOCOLOR}"
        return 1
    fi

    return
}

#####################################################################################################################
#
# Function for check if a variable is in the ENV with a value
# Param $1 : variable --> Variable to search
# Param $2 : value --> Value of variable to search
#
#####################################################################################################################

function checkIfVarInEnvWithValue {

    local variable=$1
    local value=$2
    local variableFind="${variable}=${value}"
    local variableEnv=$(env | grep ${variable})

    if [ "${variableEnv}" = "${variableFind}" ]; then
        echo -e "${GREEN}[INFO] ${variableFind} is in the ENV ${NOCOLOR}"
    else
        echo -e "${RED}[ERROR] ${variableFind} is NOT in the ENV ${NOCOLOR}"
        return 1
    fi

    return
}

#####################################################################################################################
#
# Function for check if modified date of a file is today
# Param $1 : pathFile --> Path of file to check
#
#####################################################################################################################

function checkIfModifiedDateFileEqualToday {

    local pathFile=$1
    local modifiedDateFile=$(stat -c '%y' $pathFile | cut -d' ' -f 1)
    local actualDay=""
    getActualDay actualDay
    if [ "$modifiedDateFile" = "$actualDay" ]; then
        echo -e "${GREEN}[INFO] The file $pathFile has a value $modifiedDateFile in modify Date ${NOCOLOR}"
    else
        echo -e "${RED}[ERROR] The file modified date is $modifiedDateFile and today is $actualDay ${NOCOLOR}"
        return 1
    fi
    return
}

#####################################################################################################################
#
# Function for get today date
# Param $1 : Variable that will contain date today
#
#####################################################################################################################

function getActualDay {

    actualDay=`date +"%Y-%m-%d"`
    eval "$1=$actualDay"
}


#####################################################################################################################
#
# Function for check if a certificate is in keystore
# Param $1 : cerficateName --> Name of certificate
# Param $2 : keystorePath --> Path of keystore
#
#####################################################################################################################

function checkIfCertificateIsInKeystore {

    local cerficateName=$1
    local keystorePath=$2
    existCert=$(keytool -list -v -keystore $keystorePath -storepass changeit | grep $cerficateName)

    if [ "$existCert" = "" ]; then
        echo -e "${RED}[ERROR] The certificate $cerficateName is NOT in keystore $keystorePath ${NOCOLOR}"
    else
        echo -e "${GREEN}[INFO] The certificate $cerficateName is in keystore $keystorePath ${NOCOLOR}"
    fi

}