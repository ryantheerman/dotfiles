# zsh environment variables

# editor
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

typeset -U path  # Deduplicate array
path=(
        $HOME/.local/bin
        $HOME/scripts
        $HOME/scripts/cron
        /usr/bin/ncspot
        $path  # Existing system paths
    )

# bc defaults
export BC_ENV_ARGS=/$HOME/.bc

# terminal color
export GREP_COLOR='01:31'

# postgres variables
export PGUSER="datalord"

## animated wallpapers
# snowfall wallpaper
export LIVE_WALLPAPER_WORKSPACE=$HOME/videos/animated-wallpapers/snowfall.mp4
export LIVE_WALLPAPER_BACKDROP=$HOME/videos/animated-wallpapers/snowfall.mp4
# waves wallpaper
#export LIVE_WALLPAPER_WORKSPACE=$HOME/videos/animated-wallpapers/waves.mp4
#export LIVE_WALLPAPER_BACKDROP=$HOME/videos/animated-wallpapers/waves.mp4

## Colored man pages ##
export MANPAGER="less -R --use-color -Dd+b -Du+y"
export MANROFFOPT="-P -c"

## no sudo with virsh commands
export LIBVIRT_DEFAULT_URL="qemu:///system"

## .pac* file diff customization
export DIFFPROG="nvim -d" pacdiff

## autossh logs
export AUTOSSH_DEBUG=1
export AUTOSSH_LOGFILE=/tmp/autossh.log

## remind shortcut
export DOTREMINDERS=$HOME/.reminders/10.rem
