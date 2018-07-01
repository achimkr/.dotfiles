setxkbmap -layout de
xmodmap ~/.xmodmaprc
systemctl --user import-environment DISPLAY
export QT_QPA_PLATFORMTHEME=gtk2
exec i3
