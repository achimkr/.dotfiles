#!/bin/bash

cd /home/achim/vpn

novpn="None"

declare -A vpns
for file in *; do
	if [ "$(echo $file | awk -F '.' '{print $NF}')" == "ovpn" ]; then
		proto=$(echo $file | awk -F '[_-]' '{print $(NF-1)}')
		place=$(echo $file | awk -F '[_-]' '{print $(NF-2)}')
		vpns["$place$proto"]=$file
		echo "selectable: $place$proto"
	fi
done

if [ pgrep openvpn ]; then
	curActPath=$(ps aux | grep $(pgrep openvpn) | awk '$11=="openvpn"{print $NF}')
	curActProto=$(echo $curActPath | awk -F '[_-]' '{print $(NF-1)}')
	curActPlace=$(echo $curActPath | awk -F '[_-]' '{print $(NF-2)}')
	echo "currently selected: $curActPlace$curActProto"
	vpns["$curActPlace$curActProto"]=""
fi

selection=$(echo "$novpn ${!vpns[@]}" | tr " " "\n" | rofi -dmenu)

if [ $? -eq 0 ]; then
	pkill openvpn
	if [ "$selection" != "$novpn" ]; then
		openvpn ${vpns[$selection]} &
	fi
fi
