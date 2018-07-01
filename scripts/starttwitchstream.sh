#!/bin/bash

if [ "$1" == "-h" -o "$1" == "--help" ]; then
    echo "Starts a twitch livestream using streamlink and its respective chatbox using firefox."
    echo " -nv prevents video from starting"
    echo " -nc prevents chat from opening"
    exit;
fi

if [ "$2" != "-nc" -a "$3" != "-nc" ]; then
    echo "Starting chat";
    firefox --new-window https://www.twitch.tv/popout/$1/chat?popout=sda &
fi

if [ "$2" != "-nv" -a "$3" != "-nv" ]; then
    echo "Starting video";
    streamlink twitch.tv/$1 best &
fi
