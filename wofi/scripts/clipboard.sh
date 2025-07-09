# ~/.config/wofi/scripts/clipboard.sh
#
#!/bin/bash

cliphist list | wofi --dmenu | cliphist decode | wl copy
