# zsh environment variables

# editor
export EDITOR=/usr/bin/vim

# scripts

typeset -U path  # Deduplicate array
path=(
        $HOME/.local/bin
        $HOME/scripts
        $HOME/scripts/cron
        $HOME/scripts/i3status_init
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

export LIBVIRT_DEFAULT_URL="qemu:///system"
