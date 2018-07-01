#!/bin/bash

#This script will find the focused window and if that is a terminal it will extract the working directory from the title.
#Finally it will open a new terminal at that path.

terminalPath=$(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | grep -o -P "0x[0-9a-f]*") | grep "WM_NAME(STRING)" |  awk -F "[:\"]" ' {print $3} '| sed s/"~"/"\/home\/achim"/)

if [ $1 == "-s" ]; then
    echo $terminalPath
    exit;   
fi

if [ "$terminalPath" != "" ]; then              #Replace check with regex of valid path
    exec xfce4-terminal --working-directory="$terminalPath";
else        
    exec xfce4-terminal;
fi
