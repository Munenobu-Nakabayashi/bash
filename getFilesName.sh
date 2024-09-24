#!/bin/bash

wildCard="/*"
CURDIR=$(pwd)$wildCard
cd "$(dirname "$0")"

date=`date "+%Y%m%d"`
extension=".txt"
fileName=$date$extension

fileArray=()
dirArray=()

if [ -e ./$fileName ]; then
	:
else
	cat /dev/null > ./${fileName}
fi

for filePath in $CURDIR; do
	if [ -f $filePath ] ; then
		fileArray+=("$filePath")
	elif [ -d $filePath ] ; then
		dirArray+=("$filePath")
	fi
done

echo "--- File Names ---" >> ./${fileName}
for i in ${fileArray[@]}; do
	echo $i >> ./${fileName}
done

echo "" >> ./${fileName}	# Add a Blank line
echo "--- Dir Names ---" >> ./${fileName}
for i in ${dirArray[@]}; do
	echo $i >> ./${fileName}
done

exit
