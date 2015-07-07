#!/bin/bash

INPUT=${1-respondents.csv} # Get csv from command line or default to respondents.csv
BUCKET=${2-test} #Get S3 bucket name from command line or default to test

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

(tail -n +1 $INPUT ; echo -n)| while IFS=, read RESPONDENT REPOSITORY; do
	echo "Fetching $REPOSITORY"
	REPO="$(basename $REPOSITORY)"

	REPONAME="${REPO%.git}"

	git clone $REPOSITORY $RESPONDENT
done
