#Include general shell settings (i.e Aliases and functions)
[[ -f $HOME/.shellrc ]] && source $HOME/.shellrc

# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistory
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob nomatch MENU_COMPLETE
unsetopt beep notify CASE_GLOB
bindkey -v
zstyle :compinstall filename '/home/achim/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#Keybindings
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key
bindkey -M vicmd '/' history-incremental-search-backward

#Enable syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# PROMPT Setup
PS1=''

gitbranch(){
	CYAN='%B%F{cyan}'
	MAGENTA='%B%F{magenta}'
	OFF='%f%b'
	COLOR=''

	gbranch=$(git branch 2> /dev/null)
	if [ $? -eq 0 ]; then
		
		s=$(git status 2> /dev/null)
		if [ $? -ne 0 ]; then
			return
		fi

		echo $s | grep "is ahead" > /dev/null

		if [ $? -eq 0 ]; then
			COLOR=$MAGENTA
		else
			COLOR=$CYAN
		fi

		branch=$(echo $gbranch | awk '$1 == "*" { print $2 }')
		echo "${COLOR}($branch)${OFF}"
	fi
}

precmd(){
	EXITSTATUS="$?"
	GREEN='%B%F{046}'
	RED='%B%F{009}'
	BLUE='%B%F{blue}'
	WHITE='%B%F{231}'
	
	OFF='%f%b'

	RPS1="$(gitbranch) $BLUE%0~$OFF"
	if [ "$EXITSTATUS" -eq 0 ]; then
		PS1="$GREEN<$OFF%n$GREEN@$OFF%M$GREEN>$OFF"	
	else
		PS1="$RED<$OFF%n$RED@$OFF%M$RED>$OFF"	
	fi

	if [[ ! -o login ]]; then
	    #Set TERM_PATH Window environment variable to current working directory
		base64_path="$(echo $(pwd) | base64 -)"
		echo "precmd $base64_path" >> /tmp/newTerm_out.txt
		xprop -id $(xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}') -format TERM_PATH 8s -set TERM_PATH $base64_path
	fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
