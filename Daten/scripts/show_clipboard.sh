#!/bin/bash

xclip -selection clipboard -t image/png -o | feh -
[ $? -ne 0 ] && xclip -selection clipboard -t image/jpg -o | feh -
[ $? -ne 0 ] && notify-send "Clipoard neither jpg nor png"
