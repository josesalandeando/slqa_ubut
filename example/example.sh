#!/usr/bin/env bash

function addNumbers {

    local num1=$1
    local num2=$2
    local res=$3
    local file=$4
    local error=0

    local is_number='^-?[0-9]+([.][0-9]+)?$'
    if ! [[ $num1 =~ $is_number ]]; then
       echo "[ERROR] The first parameter is not a number: $num1"
       error=1
    fi

    if ! [[ $num2 =~ $is_number ]]; then
       echo "[ERROR] The second parameter is not a number: $num2"
       error=1
    fi


    if [ ! "$file" = "" ]; then
        if [ ! -e $file ]; then
            echo "[ERROR] File $file NOT EXISTS"
            error=1
        fi
    else
        echo "[ERROR] There is no pathfile in parameters"
        error=1
    fi

    if [ ! "$error" = "1" ]; then
        eval "$res=$(($num1+$num2))"
        echo "[INFO] The result add is: ${!res}"
        echo "[INFO] Writing result in the file: $file"
        echo "RES: ${!res}" > ${file}
    else
        echo "[ERROR] It is not possible to do add"
        return 1
    fi

    return

}