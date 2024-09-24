#!/bin/bash

CURDIR=$(pwd)$wildCard
cd "$(dirname "$0")"

date=`date "+%Y%m%d"`
extension=".txt"
fileName=$date$extension

cat /dev/null > ./${fileName}

while true
do
	sleep 2
	date '+%Y/%m/%d %H:%M:%S' >> ./${fileName}
	echo `date '+%Y/%m/%d %H:%M:%S'`
done

exit
