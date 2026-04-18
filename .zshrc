### SOURCE CONFIGS ###
# zsh
source ~/.zsh_aliases
source ~/.zsh_functions
# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# zsh syntax highlighting
source /home/match/projects/misc/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
zstyle ':vcs_info:git:*' formats 'git:[%b] '
zstyle ':vcs_info:*' disable-patterns \
    "${HOME}(|/*)" \
    "${HOME}/scripts(|/*)" \
    "${HOME}/notes(|/*)" \
    "${HOME}/.reminders(|/*)"
setopt PROMPT_SUBST
PROMPT='%F{green}%n@%m %F{blue}%~%b%f %F{red}%B${vcs_info_msg_0_}%b%f> '
