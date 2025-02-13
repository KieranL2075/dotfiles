#!/bin/bash

HIDDEN_WORKSPACE="10"

# Get all minimized windows (in the hidden workspace)
MINIMIZED_WINDOWS=$(hyprctl clients -j | jq -r --arg WORKSPACE "$HIDDEN_WORKSPACE" \
    '.[] | select(.workspace.id == ($WORKSPACE | tonumber)) | .title')

if [ -z "$MINIMIZED_WINDOWS" ]; then
    echo "No minimized windows"
else
    # Generate clickable entries for Waybar
    while read -r TITLE; do
        echo " $TITLE | bash='/path/to/toggle_minimize.sh \"${TITLE}\"' terminal=false"
    done <<< "$MINIMIZED_WINDOWS"
fi
