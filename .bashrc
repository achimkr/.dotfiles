[[ $- != *i* ]] && return

function exitstatus {

        EXITSTATUS="$?"
        BOLD="\[\033[1m\]"
        RED="\[\033[1;31m\]"
        GREEN="\[\e[32;1m\]"
        BLUE="\[\e[34;1m\]"

        OFF="\[\033[m\]"
        OK="\[\e[32;1m\]"
        FAIL="\[\033[1;31m\]"


        if [ "${EXITSTATUS}" -eq 0 ]; then
                PS1="${OK}<${OFF}\u${OK}@${OFF}\h ${BLUE}\W${OFF} ${OK}>${OFF}${BOLD}\$${OFF}"
        else
                PS1="${FAIL}<${OFF}\u${FAIL}@${OFF}\h ${BLUE}\W${OFF} ${FAIL}>${OFF}${BOLD}\$${OFF}"
        fi

        PS2="${BOLD}>${OFF} "
}
PROMPT_COMMAND=exitstatus

[[ -f .shellrc ]] && source .shellrc

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
