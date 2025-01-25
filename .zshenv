# zsh environment variables

# editor
export EDITOR=/usr/bin/vim

# scripts
export PATH=$PATH:/home/match/scripts
export PATH=$PATH:/home/match/scripts/cron

# bc defaults
export BC_ENV_ARGS=/home/match/.bc

# terminal color
export GREP_COLOR='01:31'

# postgres variables
export PGUSER="datalord"

## Colored man pages ##
#export LESS='-R --use-color -Dd+r$Du+g$'

#export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
#export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
#export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
#export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
#export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
#export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
#export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
#export GROFF_NO_SGR=1

export MANPAGER="less -R --use-color -Dd+r -Du+g"
export MANROFFOPT="-P -c"
