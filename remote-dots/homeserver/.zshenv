# zsh environment variables

# editor
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

typeset -U path  # Deduplicate array
path=(
        $HOME/.local/bin
        $HOME/scripts
        $path  # Existing system paths
    )

# terminal color
export GREP_COLOR='01:31'

## Colored man pages ##
export MANPAGER="less -R --use-color -Dd+r -Du+g"
export MANROFFOPT="-P -c"

# virsh default socket
export LIBVIRT_DEFAULT_URI="qemu:///system"
