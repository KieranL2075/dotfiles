#!/bin/bash

# Define the output CSS file
output_css="/home/Kieran/.cache/wal/colors-waybar.css"
output_kitty="/home/Kieran/.cache/wal/colors-kitty.conf"

# Run wal to generate the color palette (optional, if already run, comment this line)
# wal -i "$1"
# Define the path to the colors.sh file
colors_sh="$HOME/.cache/wal/colors.sh"

# Check if colors.sh exists
if [ ! -f "$colors_sh" ]; then
    echo "Error: colors.sh not found at $colors_sh"
    exit 1
fi

# Source the colors.sh file to load the color variables
# shellcheck disable=SC1090
source "$colors_sh"

# Write the CSS file
{
    echo "@define-color foreground $color7;"
    echo "@define-color background $color0;"
    echo "@define-color cursor $color7;"
    echo ""
    for i in {0..15}; do
        var_name="color$i"
        color_value="${!var_name}" # Indirect variable reference to get color$i
        echo "@define-color color$i $color_value;"
    done
} > "$output_css"

# Define the path to the colors.sh file
colors_sh="$HOME/.cache/wal/colors.sh"

# Check if colors.sh exists
if [ ! -f "$colors_sh" ]; then
    echo "Error: colors.sh not found at $colors_sh"
    exit 1
fi

# Source the colors.sh file to load the color variables
# shellcheck disable=SC1090
source "$colors_sh"


# Write the kitty.conf file
{
    echo "foreground   $color7"
    echo "background   $color0"
    echo "cursor       $color7"
    echo ""
    for i in {0..7}; do
        var_name="color$i"
        color_value="${!var_name}" # Indirect variable reference to get color$i
        if [[ "$var_name" == "color1" ]]; then
            echo "color1        #ef476f"
        elif [[ "$var_name" == "color2" ]]; then
            echo "color2        #06d6a0"
        else
            echo "color$i       $color_value"
        fi
    done
    echo ""
    for i in {8..15}; do
        var_name="color$i"
        color_value="${!var_name}" # Indirect variable reference to get color$i
        echo "color$i       $color_value"
    done
} > "$output_kitty"

echo "Kitty color configuration file generated at $output_kitty"
echo "CSS color file generated at $output_css"