#!/bin/bash

CURDIR=$(pwd)$wildCard
cd "$(dirname "$0")"

cat /dev/null > ./work.txt
workA=./workA.txt
workB=./workB.txt

# fileArray=()

yyyymmdd=$(date -d "$(date '+%Y%m01') 1 month ago" "+%Y%m%d")
lastMonth=$(echo ${yyyymmdd} | cut -c 1-6)

find ${CURDIR} -type f -name "${lastMonth}*.txt" > ${workA}
# sed -i -e 's/$/\r/' ${workFile}
cat ${workA} | tr '\n' ' ' > ${workB}
echo "" >> ${workB}	# Add a LF

while read line1
do
	# fileArray+=("$line1")
	str="$line1"
done < ${workB}

#gzip "$(echo ${str})" -c > ./${lastMonth}.gz
tar -cvf ./${lastMonth}.tar ${str}
if [ -e ./${lastMonth}.tar.gz ] ; then
	rm -rf ./${lastMonth}.tar.gz	# Remove a Old Same .tar.gz File.
fi
gzip ./${lastMonth}.tar

if [ -d ./${lastMonth}.bkup ] ; then
	:
else
	mkdir ./${lastMonth}.bkup	# BKUP Folder
fi
mv -f ./${lastMonth}*.txt ./${lastMonth}.bkup	# --force option

# rm -rf ${workFile}

exit
