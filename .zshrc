### SOURCE CONFIGS ###
# zsh
source ~/.zsh_aliases
source ~/.zsh_functions
source ~/.zshenv
# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

### HISTORY ###
HISTFILE=~/.zsh_history
HISTSIZE=1000000000
SAVEHIST=1000000000
# enable history update during and between sessions
setopt append_history
setopt extended_history
setopt inc_append_history
setopt share_history

### MISC ###
# enable vim keybindings
bindkey -v

## PROMPT
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%~%f %F{red}${vcs_info_msg_0_}%f$ '

