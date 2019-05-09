#!/bin/bash

#This script will find the focused window and if that is a terminal it will working directory from the xorg environment variable TERM_PATH.
#TERM_PATH must be set by the user (for example put "xprop -id $(xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}') -format TERM_PATH 8s -set TERM_PATH "$(pwd)"" in PROMPT_COMMAND in bash or precmd in zsh)
#This script is designed to work with termite should be easily changeable to another terminal

#The path is stored in base64 due to encoding issues of special characters in the path of the xprop output.

curWinId=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}')

program=$(xprop -id $curWinId WM_CLASS | awk '{print $3}' | sed 's/[",]//g')

if [ "$program" == "termite" ]; then
	base64_path=$(xprop -id $curWinId TERM_PATH | awk '{print $3}' | sed 's/"//g')
	terminal_path="$(echo $base64_path | base64 -d - )"

	[ "$1" != "-s" ] && exec termite -d $terminal_path
else
	exec termite
fi
