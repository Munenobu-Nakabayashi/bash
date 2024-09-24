#!/bin/bash

CURDIR=$(pwd)
cd "$(dirname "$0")"

date=`date "+%Y%m%d"`
extension=".txt"
fileName=$date$extension

if [ -e ./$fileName ]; then
	:	# Exists Today's File
else
	cat /dev/null > ./${fileName}	# Not Exixts Today's File
fi

exit
