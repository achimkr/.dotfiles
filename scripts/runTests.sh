#! /bin/bash
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
OFF='\033[0m'

testFiles=""

if [ $# -gt 1 ]; then
	testFiles="$2/"
	#echo "testfiles = $testFiles"
elif [ $# -lt 1 ]; then
	echo "No executable specified!"
	exit 1
fi

ex=$1

if [ ! -x $ex ]; then
	echo "File \"$ex\" doesn't exist or isn't executable!"
	exit 1
fi

cases=0
passed=0

shopt -s nullglob
for i in $testFiles*.in; do
	#echo "DEBUG: testing $i"
	cases=$(($cases + 1))

	name="$(echo $i | awk -F "." '{print $(NF - 1)}')"
	if [ "$testFiles" == "./" ]; then
		name=".$name"
	fi	

	#echo "DEBUG: testing $name"	

	if [ ! -f "$name.ans" ]; then
		echo "$name.in doesn't have corresponding $name.ans file!"
	fi

	result=$($ex < $i | diff - "$name.ans")
	#result=$($ex < $i)
	exitCd="0";
	#differ=$(echo $result | diff - "$name.ans")

	if [ "$exitCd" != "0" ]; then
		echo -e "${RED}$name failed! Exitcode: $exitCd${OFF}"	
	elif [ "$result" == "" ]; then
		echo -e "${GREEN}$name passed!${OFF}"
		passed=$(($passed + 1))	
	else
		echo -e "${RED}$name failed:${OFF}"		
		echo "$result"
	fi
done

echo -e "${BLUE}---------------------------------------${OFF}"

if [ $cases -eq $passed ]; then
	echo -e "${GREEN}All $cases cases passed!${OFF}"
else
	echo -e "${RED}$passed out of $cases cases passed!${OFF}"
fi
