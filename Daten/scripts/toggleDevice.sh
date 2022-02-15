#!/bin/bash

state=$(xinput list-props $1 | awk '/Device\ Enabled/{print $4}')
#echo "state $state"
nextState=0

if [ $state -eq 0 ]; then
	nextState=1
else
	nextState=0
fi
#echo "nextState $nextState"

xinput set-prop $1 "Device Enabled" $nextState
