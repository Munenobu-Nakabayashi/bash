#!/bin/bash

CURDIR=$(pwd)
cd "$(dirname "$0")"

# No.0 Arg is Command Line. Use No.1, No.2 Args.
from=$1
to=$2

# Use sed command & Args 
sed -i -e "s/${from}/${to}/g" ./zoo.txt

exit
