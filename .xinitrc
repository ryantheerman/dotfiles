setxkbmap us -v dvorak
xset r rate 200 30
xset s 1800 1800 +dpms
xmodmap $HOME/.Xmodmap
xcape -e 'Hyper_R=Escape'
xcape -e 'Control_L=Control_L|a'
# xcape -e 'Shift_L=Shift_L|Hyper_R|2'
unclutter --timeout 5 --jitter 100 --ignore-scrolling &
xrdb $HOME/.Xresources
$HOME/scripts/cron/uptime.sh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_github
ssh-add ~/.ssh/id_aur
libinput-gestures-setup start

# write script to handle this
xrandr --output eDP-1 --mode 1920x1200

#if [[ $(xrandr --query | grep "DP-3-6-8 connected") ]]; then
    $HOME/.screenlayout/double-externals.sh
#fi

numlockx &
redshift &
picom &

# moon specific configs
if [[ $($HOME/scripts/readMoon.sh) == "ganymede" ]]; then
    xinput set-button-map 11 1 1 3 4 5 6 7
    xscreensaver --no-splash &
    xss-lock -- xscreensaver-command -lock &
elif [[ $($HOME/scripts/readMoon.sh) == "callisto" ]]; then
    xinput set-button-map 10 1 1 3 4 5 6 7
fi

exec i3
