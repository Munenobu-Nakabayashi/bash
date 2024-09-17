#!/bin/bash
set -euxo pipefail
CURDIR=$(pwd)
cd "$(dirname "$0")"

fileName=./ITShisanDaicho.txt

cat /dev/null > ./icmpEchoReplyCheck.txt
resultFileName=./icmpEchoReplyCheck.txt
cat /dev/null > ./timeOutCheck.txt
workFileName=./timeOutCheck.txt

while read line
do
	ping "${line}" >> "${workFileName}"
	# ping -c 1 "${line}" >> "${workFileName}"
	
	cat "${workFileName}" | while read line2
	do
		if [[ "$line2" == *expired* ]]; then
		# if [[ "$line2" == *out* ]]; then
			echo "${line}: NG" >> "${resultFileName}"
		else
			echo "${line}: OK" >> "${resultFileName}"
		fi
	done
	cat /dev/null > "${workFileName}"
	
done < ${fileName}

exit
