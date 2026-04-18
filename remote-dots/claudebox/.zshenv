# zsh environment variables

# editor
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

typeset -U path  # Deduplicate array
path=(
        $HOME/.local/bin
        $HOME/scripts
        $HOME/workshop/init/scripts
        $path  # Existing system paths
    )

# terminal color
export GREP_COLOR='01:31'

## Colored man pages ##
export MANPAGER="less -R --use-color -Dd+b -Du+y"
export MANROFFOPT="-P -c"
