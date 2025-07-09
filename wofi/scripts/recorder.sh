# ~/.config/wofi/scripts/recorder.sh

#!/bin/bash

entries="⏺️ Record Desktop\n Record Area"
RECORDING_DIR=${HOME}/Videos/Recordings

# Ensure the directory exists
mkdir -p "$RECORDING_DIR"

selected=$(echo -e $entries|wofi --width 250 --height 100 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
  desktop)
    wf-recorder -f "$RECORDING_DIR/$(date +'%Y-%m-%d_%H-%M-%S.mp4')";;
  area)
    wf-recorder -g "$(slurp)" -f "$RECORDING_DIR/$(date +'%Y-%m-%d_%H-%M-%S.mp4')";;
esac
