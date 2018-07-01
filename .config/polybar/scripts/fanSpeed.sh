#!/bin/bash

speed=$(sensors | grep 'fan' | awk '{print $2}')

if [[ $speed != "0" ]]; then
	echo $speed
else
	echo ""
fi
