#!/bin/bash


function checks()
{
    if [[ $2 != $3 ]]
    then
        echo "The $1 is not compliant. The current policy is: $2"
    else
        echo "The $1 is compliant. Current value $3"
    fi
}


pmax=$(egrep -i '^PASS_MAX_DAYS' /etc/login.defs | awk ' { print $2 } ')

# Check for password max
checks "Password Max Days" "365" "${pmax}"