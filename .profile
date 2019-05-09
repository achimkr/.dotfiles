export PATH=".:$HOME/prgms:$HOME/scripts:$PATH"

if ! pgrep Xorg; then
	exec startx
fi
