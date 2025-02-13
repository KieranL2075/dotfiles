#!/bin/bash

# Get workspace data from Hyprland IPC
workspaces=$(hyprctl workspaces -j) # JSON output
clients=$(hyprctl clients -j)        # JSON output

# Use jq to parse JSON (make sure jq is installed)
output=""

# Iterate over each workspace and gather window titles
for workspace_id in $(echo "$workspaces" | jq -r '.[].id'); do
    workspace_name=$(echo "$workspaces" | jq -r ".[] | select(.id == $workspace_id) | .name")
    windows=$(echo "$clients" | jq -r --argjson wid "$workspace_id" '.[] | select(.workspace.id == $wid) | .title')

    # Collect window titles in a comma-separated list
    window_titles=$(echo "$windows" | paste -sd ", " -)

    # Format the tooltip for Waybar
    output+="{\"name\": \"$workspace_name\", \"tooltip\": \"$window_titles\"},"
done

# Output JSON array for Waybar
echo "[${output%,}]"
