#!/bin/sh
updates=$(checkupdates 2> /dev/null)
if [ $? -ne 0 ]; then
	exit 1
fi

updates=$(echo "$updates" | wc -l)
if [ "$updates" -gt 30 ]; then
    echo "$updates"
else
    echo ""
fi
