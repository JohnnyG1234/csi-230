#!/bin/bash


function checks()
{
    if [[ $2 != $3 ]]
    then
        echo "The $1 is not compliant. The current policy should be: $2. The current value is: $3"
    else
        echo "The $1 is compliant. Current value $3"
    fi
}


pmax=$(egrep -i '^PASS_MAX_DAYS' /etc/login.defs | awk ' { print $2 } ')

# Check for password max
checks "Password Max Days" "365" "${pmax}"

# Check for password min
pmin=$(egrep -i '^PASS_MIN_DAYS' /etc/login.defs | awk ' { print $2 } ')
checks "Password min days" "14" "${pmin}"

# Check the pass warn age
pwarn=$(egrep -i '^PASS_WARN_AGE' /etc/login.defs | awk ' { print $2 } ')
checks "Password warn age" "7" "${pwarn}"