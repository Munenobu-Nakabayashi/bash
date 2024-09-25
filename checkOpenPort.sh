#!/bin/bash
# set -euxo pipefail
CURDIR=$(pwd)
cd "$(dirname "$0")"

nodeAddress=./nodeAddress.txt
portNo=./portNo.txt
cat /dev/null > ./result.txt
cat /dev/null > ./work1.txt
cat /dev/null > ./work2.txt
cat /dev/null > ./work3.txt
result=./result.txt
work1=./work1.txt
work2=./work2.txt
work3=./work3.txt

while read line1	# read node addresses.
do
	while read line2	# read port numbers.
	do
		curl -v "${line1}"/ip:"${line2}" > "${work1}" 2>&1
		# sleep 10
		cat "${work1}" | grep Failed > "${work2}"
		# if [ wc -l "${work2}" | awk '{print "${1}"}' -eq 0 ]; then
		cat ${work2} | wc -l > "${work3}"
		while read line3
		do
			# echo ${line3}
			if [ ${line3} -eq 0 ]; then
				echo "${line1}:${line2} Opened!" >> "${result}"
			else
				echo "${line1}:${line2} Closed." >> "${result}"
			fi
		done < ${work3}
	done < ${portNo}

	cat /dev/null > "${work1}"
	cat /dev/null > "${work2}"
	cat /dev/null > "${work3}"
	
done < ${nodeAddress}

exit
