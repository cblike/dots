# ~/.config/wofi/scripts/screenshot.sh
#
#!/bin/bash

entries="📷 Capture Desktop\n Capture Area \n Capture Window"
SCREENSHOT_DIR=${HOME}/Pictures/Screenshots

# Ensure the directory exists
mkdir -p "$SCREENSHOT_DIT"

selected=$(echo -e $entries|wofi --width 250 --height 150 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
	desktop)
		grim "$SCREENSHOT_DIR/$(date +'%Y-%m-%d_%H-%M-%S_grim.png')";;
	area)
		grim -g "$(slurp)" "$SCREENSHOT_DIR/$(date +'%Y-%m-%d_%H-%M-%S_grim.png')";;
	window)
                grim -g "$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" "$SCREENSHOT_DIR/$(date +'%Y-%m-%d_%H-%M-%S_grim.png')";;
esac
