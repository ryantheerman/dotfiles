setxkbmap us -v dvorak
xset r rate 200 30
xset s 1800 1800 +dpms
xmodmap $HOME/.Xmodmap
xcape -e 'Hyper_R=Escape'
xcape -e 'Control_L=Control_L|a'
# xcape -e 'Shift_L=Shift_L|Hyper_R|2'
xinput set-button-map 11 1 1 3 4 5 6 7
unclutter --timeout 5 --jitter 100 --ignore-scrolling &
xrdb $HOME/.Xresources
/home/match/scripts/cron/uptime.sh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_github
ssh-add ~/.ssh/id_aur
libinput-gestures-setup start

xrandr --output eDP-1 --mode 1920x1200

if [[ $(xrandr --query | grep "DP-2-6-8 connected") ]]; then
    xrandr --newmode "2560x1440_30.00" 146.25 2560 2680 2944 3328 1440 1443 1448 1468 -hsync +vsync
    xrandr --newmode "1920x1080_60.00" 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync

    xrandr --addmode eDP-1 1920x1080_60.00
    xrandr --addmode DP-2-6-8 2560x1440_30.00
    xrandr --addmode DP-2-6-1-8 2560x1440_30.00

    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1613x1440 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-3 --off --output HDMI-3 --off --output DP-2-5 --off --output DP-2-6 --off --output DP-2-6-8 --mode 2560x1440_30.00 --pos 0x0 --rotate normal --output DP-2-6-1 --off --output DP-2-6-1-8 --mode 2560x1440_30.00 --pos 2560x0 --rotate normal
fi

numlockx &
redshift &
picom &
xscreensaver --no-splash &
xss-lock -- xscreensaver-command -lock &

exec i3
