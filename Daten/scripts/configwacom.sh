#!/bin/bash
source mon-utils.sh

monitor=$(connected | rofi -dmenu)
devices=$(xsetwacom list devices | awk '{print $8}')

for dev in $devices; do
	xsetwacom --set $dev MapToOutput $monitor
done
