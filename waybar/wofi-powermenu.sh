#!/bin/bash
if pgrep -x "wofi" > /dev/null; then pkill -x "wofi"; exit 0; fi
options="Shutdown\nReboot\nLock\nSuspend\nLogout"
chosen=$(echo -e "$options" | wofi --dmenu --style ~/.config/wofi/style-powermenu.css)
case "$chosen" in
    Shutdown) systemctl poweroff ;;
    Reboot) systemctl reboot ;;
    Lock) swaylock ;;
    Suspend) systemctl suspend ;;
    Logout) swaymsg exit ;;
esac
