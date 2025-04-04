# x configs
setxkbmap us -v dvorak
xset r rate 200 30
xset s 1800 1800 +dpms
xmodmap $HOME/.Xmodmap
xcape -e 'Hyper_R=Escape'
xcape -e 'Control_L=Control_L|a'
# xcape -e 'Shift_L=Shift_L|Hyper_R|2'
xrdb $HOME/.Xresources

# init uptime
$HOME/scripts/cron/uptime.sh

# populate i3status bar module with active gpu
$HOME/scripts/gpu-check.sh

# hide mouse cursor after 5 seconds inactivity
unclutter --timeout 5 --jitter 100 --ignore-scrolling &

# set up ssh keys
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_github
ssh-add ~/.ssh/id_aur

# allow for 3 finger swipe
libinput-gestures-setup start

# init bluetooth status
if [[ $(rfkill | grep "tpacpi_bluetooth_sw unblocked unblocked") || $(rfkill | grep "hci0           unblocked unblocked") ]]; then
    echo "on" > /home/match/.config/i3status/bluetooth
else
    echo "<span color='red'>off</span>" /home/match/.config/i3status/bluetooth
fi

# background processes
numlockx &
redshift &
picom &

# moon specific configs
if [[ $($HOME/scripts/readMoon.sh) == "ganymede" ]]; then
    # xrandr config
    if [[ $(glxinfo | grep "renderer string: Mesa Intel(R)") ]]; then
        xrandr --output eDP-1 --mode 1920x1200
    else
        xrandr --setprovideroutputsource modesetting NVIDIA-0
        xrandr --output eDP-1-1 --mode 1920x1200
    fi

    # swap middle click for left click
    xinput set-button-map 11 1 1 3 4 5 6 7
    xinput set-button-map 15 1 1 3 4 5 6 7

    # set screensaver and lock
    xscreensaver --no-splash &
    xss-lock -- xscreensaver-command -lock &
elif [[ $($HOME/scripts/readMoon.sh) == "callisto" ]]; then
    # xrandr config
    xrandr --output eDP-1 --mode 1920x1200

    # swap middle click for left click
    xinput set-button-map 10 1 1 3 4 5 6 7

    # set lock
    xss-lock -- $HOME/scripts/lock.sh -lock &
fi

exec i3
