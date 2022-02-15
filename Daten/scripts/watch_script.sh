#!/bin/bash

input=$1
cmd=$2
dir=$(dirname $input)

inotifywait -e close_write,moved_to,create -m $dir |
while read -r directory events filename; do
  if [ "$filename" = $(basename $input) ]; then
	if [ "$events" = "CLOSE_WRITE,CLOSE" ]; then
		echo "---------- Running command: '$cmd' ----------"
		$cmd
		echo "---------- Command finished. ----------"
	fi
  fi
done
