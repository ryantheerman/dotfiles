#!/bin/sh
# x configs
setxkbmap us -v dvorak
xset r rate 200 30
xset s 600 600 +dpms
#xmodmap $HOME/.Xmodmap
#xcape -e 'Hyper_R=Escape'
#xcape -e 'Control_L=Control_L|a'
xrdb $HOME/.Xresources

# init keymap i3status
if setxkbmap -query | grep -iq variant; then
    echo "<span color='pink'>dv</span>" > ~/.config/i3status/keymap
else
    echo "<span color='yellow'>qw</span>" > ~/.config/i3status/keymap
fi

# init uptime
#$HOME/scripts/cron/uptime.sh

# populate i3status bar module with active gpu
#$HOME/scripts/gpu-check.sh

# set up ssh keys
#if ! pgrep -x "ssh-agent" > /dev/null; then
#    eval "$(ssh-agent -s)"
#    ssh-add ~/.ssh/id_github
#    ssh-add ~/.ssh/id_aur
#fi

# allow for 3 finger swipe
libinput-gestures-setup start

# init bluetooth status
if [[ $(rfkill | grep "tpacpi_bluetooth_sw unblocked unblocked") || $(rfkill | grep "hci0           unblocked unblocked") ]]; then
    echo "bt" > /home/match/.config/i3status/bluetooth
else
    echo "<span color='red'>bt</span>" /home/match/.config/i3status/bluetooth
fi

# init i3status config
#~/scripts/i3status_init/i3status_init.sh

# background processes
numlockx &
redshift &
#picom &
# hide mouse cursor after 8 seconds inactivity
unclutter --timeout 8 --jitter 100 --ignore-scrolling &

# xrandr config
xrandr --output eDP-1 --mode 1920x1200

# disable touchscreen
xinput disable 11
echo "<span color='red'>touch</span>" > ~/.config/i3status/touchscreen

# swap middle click for left click
xinput set-button-map 10 1 1 3 4 5 6 7

# set lock
xss-lock -- $HOME/scripts/lock.sh &
#xautolock -time 1 -locker "$HOME/scripts/lock.sh" &
xidlehook --not-when-fullscreen --not-when-audio --detect-sleep --timer 900 'systemctl suspend-then-hibernate' '' &
#xidlehook --not-when-fullscreen --not-when-audio --detect-sleep --timer 900 '$HOME/scripts/suspend-then-hibernate-wrapper.sh' '' &

# dark mode
export GTK_THEME=Adwaita:dark
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=Fusion

exec i3
