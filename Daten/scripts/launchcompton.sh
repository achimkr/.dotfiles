#!/usr/bin/bash
killall -q compton 
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
exec "$1"
