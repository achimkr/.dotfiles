export PATH=".:$HOME/prgms:$HOME/Daten/scripts:$PATH"

if ! pgrep Xorg; then
	exec startx
fi


export PATH="$HOME/.elan/bin:$PATH"
