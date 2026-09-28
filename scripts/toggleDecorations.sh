#!/bin/bash

~/dotfiles/waybar/toggle.sh

# Define the file and strings
FILE="../hypr/conf/window.conf"
STRING1="source = $HOME/dotfiles/hypr/conf/windows/default.conf"
STRING2="source = $HOME/dotfiles/hypr/conf/windows/no-gaps.conf"
# Check if string1 exists in the file

# Check if STRING1 exists, then overwrite with STRING2
if grep -Fxq "$STRING1" "$FILE"; then
    echo "$STRING2" > "$FILE"
    echo "File overwritten with STRING2 because STRING1 existed."
    exit 0
fi

# Check if STRING2 exists, then overwrite with STRING1
if grep -Fxq "$STRING2" "$FILE"; then
    echo "$STRING1" > "$FILE"
    echo "File overwritten with STRING1 because STRING2 existed."
    exit 0
fi

# Default: Write STRING1 if neither exist
echo "$STRING1" > "$FILE"
echo "File initialized with STRING1."
sleep 1
hyprctl reload
