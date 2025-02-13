#!/bin/bash

~/dotfiles/waybar/toggle.sh

# Define the file and strings
file="../hypr/conf/window.conf"
string1="source = $HOME/dotfiles/hypr/conf/windows/default.conf"
string2="source = $HOME/dotfiles/hypr/conf/windows/no-gaps.conf"

# Check if string1 exists in the file
if grep -q "$string1" "$file"; then
    # If string1 is found, replace with string2
    echo "$string2" > "$file"
else
    # If string1 is not found, replace with string1
    echo "$string1" > "$file"
fi
