#! /usr/bin/zsh
mclashy 1>/dev/null 2>&1 &
xrandr --output DP-1 --primary --right-of HDMI-1
xrandr --dpi 200 --output HDMI-1 --rotate left
sh ~/Workspace/myCheatSheet/Backup/change_bg.sh &
pkill compton ; compton -b --config /home/lemon/.config/compton/compton.conf
# mate-power-manager
dwmstatus 2>&1 >/dev/null &
