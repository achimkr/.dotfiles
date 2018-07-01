#!/bin/bash

icon="$HOME/.config/i3/icon.png"
tmpbg='/tmp/screen.png'
res=$(xdpyinfo | grep dimension | awk -F " " ' {print $2} ')

((  $#  )) && { icon=$1;  }

scrot "$tmpbg"
convert "$tmpbg" -sample 25% -swirl 1080 -spread 3 -swirl -1080 -sample $res -blur 5 "$tmpbg"
i3lock -i "$tmpbg"
rm /tmp/screen.png
