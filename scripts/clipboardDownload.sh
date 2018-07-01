#!/bin/bash

path="/home/$(whoami)"

if [ $# -ge 2 ]; then
	path=$1
else
	expectedPath="$path/Downloads"
	if [ -d "$expectedPath" ]; then
		path=$exceptedPath
	fi
fi
	
url=$(xclip -o)

notify-send "Downloading $url to $path"

wget $url $path

if [ $? -eq 0 ]; then
	notify-send "Download of $url complete"
else
	notify-send "Download of $url failed"
fi
