# zsh environment variables

# editor
export EDITOR=/usr/bin/vim

# scripts
#export PATH=$PATH:/$HOME/scripts/
#export PATH=$PATH:/$HOME/scripts/cron
#export PATH=$PATH:/$HOME/scripts/i3status_init
#export PATH=$PATH:/usr/bin/ncspot
#export PATH="$HOME/.local/bin:$PATH"

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

# live wallpaper
export LIVE_WALLPAPER_WORKSPACE=$HOME/videos/animated-wallpapers/snowfall.mp4
export LIVE_WALLPAPER_BACKDROP=$HOME/videos/animated-wallpapers/snowfall.mp4

#export LIVE_WALLPAPER_WORKSPACE=$HOME/videos/animated-wallpapers/waves.mp4
#export LIVE_WALLPAPER_BACKDROP=$HOME/videos/animated-wallpapers/waves.3840x2160.mp4

#export LIVE_WALLPAPER_WORKSPACE=$HOME/videos/animated-wallpapers/night-sky.mp4
#export LIVE_WALLPAPER_BACKDROP=$HOME/videos/animated-wallpapers/night-sky.mp4

#export PAPER_1=/mnt/nfs/extra/ytdl/l5.mp4
#export PAPER_2=/mnt/nfs/extra/ytdl/uncon.mp4
#export PAPER_3=/mnt/nfs/extra/ytdl/l2.mp4
#export PAPER_4=/mnt/nfs/extra/ytdl/desen.mp4
#export PAPER_5=/mnt/nfs/extra/ytdl/l4.mp4
#export PAPER_6=/mnt/nfs/extra/ytdl/l3.mp4

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

export MANPAGER="less -R --use-color -Dd+b -Du+y"
export MANROFFOPT="-P -c"
