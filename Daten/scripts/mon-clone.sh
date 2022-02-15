#!/bin/bash
source mon-utils.sh

first=$(connected | rofi -dmenu)
second=$(connected | awk -v not="$first" '$1 != not{print $1}'| rofi -dmenu)

res=$( comm -12 <(resolutions "$first" | sort) <(resolutions "$second" | sort) | sort -n -r | rofi -dmenu )

xrandr --output "$first" --mode $res --output "$second" --mode $res --same-as "$first"
