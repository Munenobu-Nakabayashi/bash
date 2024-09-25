#!/bin/bash

CURDIR=$(pwd)
cd "$(dirname "$0")"

# Change CRLF -> LF and Add -c option [Not Use nkf ver.]
iconv -c --from-code SHIFT_JIS --to-code UTF-8 ./inputFile.txt | tr -d '\n' > ./outputFile.txt

exit
