#!/bin/bash

declareGlobalVar(){

	wildCard="/*"

	date=`date "+%Y%m%d"`
	extension=".txt"
	todaysFile=hash_$date$extension	# Update
	compFile=diff_$date$extension	# Update
	
	yyyymmdd=$(date -d "$(date '+%Y%m%d') yesterday" "+%Y%m%d")	
	yesterdaysFile=hash_$yyyymmdd$extension	#Update

	folderList=./FolderList.txt
}

moveToCurrentDir(){
	CURDIR=$(pwd)
	cd "$(dirname "$0")"
}

generateTodaysFile(){
	cat /dev/null > ./${todaysFile}	# initiate Today's File ( if already exists, too. )
	cat /dev/null > ./${compFile}	# initiate Today's Compare File ( if already exists, too. )
}

generateHashValue(){
	
	while read line1	# read a folder list file.
	do
		# echo ${line1}
		for filePath in ${line1}${wildCard}; do		# get all file names in the folder.
			if [ -f ${filePath} ] ; then		# Files Only, Not Directory.
				sha256sum $filePath >> ${todaysFile} 2>&1	
			fi
		done
		echo "" >> ${todaysFile}		# add a Blank line.
	done < ${folderList}

}

compareTodayWithYesterday(){
	# check if exists yesterday's Hash File
	if [ -f $yesterdaysFile ] ; then
		diff --suppress-common-lines ./${yesterdaysFile} ./${todaysFile} > ./${compFile} 2>&1	# erase -y option because ...
	else
		echo "Hash File One Day Before ( ${yesterdaysFile} ) does not exists ! Why ?" > ./${compFile}
	fi
}

main(){

	declareGlobalVar
	
	moveToCurrentDir
	
	generateTodaysFile

	generateHashValue

	compareTodayWithYesterday	# And generate a diff (comp ?) file.

}

main

exit
