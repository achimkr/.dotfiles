GREEN='%B%F{046}'
RED='%B%F{009}'
BLUE='%B%F{blue}'
OFF='%f%b'

VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

EXIT_COLOR="%(?.$GREEN.$RED)"

PROMPT='$EXIT_COLOR<$OFF%n$EXIT_COLOR@$OFF%M$EXIT_COLOR>$OFF'

RPROMPT='$(vi_mode_prompt_info)$(parse_git_dirty)$(git_prompt_info)%{$reset_color%}$BLUE%0~$OFF'

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[cyan]%}"

MODE_INDICATOR="%F{yellow}<->%f "
