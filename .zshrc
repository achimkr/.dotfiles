export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="my_theme"

ZSH_CUSTOM="${HOME}/.config/oh-my-zsh-custom"

plugins=(git rust vi-mode fzf)

source $ZSH/oh-my-zsh.sh

HISTFILE=~/.zhistory
HISTSIZE=1000000
SAVEHIST=1000000
setopt appendhistory autocd

# My general shell settings and aliases
source ~/.shellrc

#Enable syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

precmd() {
	if [[ ! -o login ]]; then
		#Set TERM_PATH Window environment variable to current working directory
		base64_path=$(echo $(pwd) | base64 -w 0 -)
		#echo "precmd $base64_path"
		xprop -id $(xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}') -format TERM_PATH 8s -set TERM_PATH $base64_path
	fi
}
