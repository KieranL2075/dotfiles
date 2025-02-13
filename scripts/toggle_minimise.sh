#!/bin/bash

HIDDEN_WORKSPACE="10"

if [ "$1" ]; then
    # Restore the window with the given title to the current workspace
    WINDOW_TITLE="$1"
    WINDOW_ID=$(hyprctl clients -j | jq -r --arg TITLE "$WINDOW_TITLE" \
        '.[] | select(.title == $TITLE) | .address')

    if [ -z "$WINDOW_ID" ]; then
        echo "Window not found!"
        exit 1
    fi

    # Get the current workspace
    CURRENT_WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')

    # Move the window to the current workspace
    hyprctl dispatch movetoworkspace "$CURRENT_WORKSPACE,address:$WINDOW_ID"
else
    # Minimize the currently focused window
    FOCUSED_WINDOW=$(hyprctl activewindow -j | jq -r '.address')

    if [ -z "$FOCUSED_WINDOW" ]; then
        echo "No focused window!"
        exit 1
    fi

    # Move the window to the hidden workspace
    hyprctl dispatch movetoworkspace "$HIDDEN_WORKSPACE,address:$FOCUSED_WINDOW"
fi
