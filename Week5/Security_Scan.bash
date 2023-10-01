#!/bin/bash

pmax=$(egrep -i '^PASS_MAX_DAYS' /etc/login.defs | awk ' { print $2 } ')

if [[ "${pmax}" != "120" ]]
then
    echo "The password max days policy is not compliant. The current policy is: ${pmax}"
else
    echo "The password max days policy is compliant"
fi