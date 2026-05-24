#!/bin/bash

# Kill existing waybar instances
killall waybar 2>/dev/null || true
sleep 0.3

# Load waybar with ml4w-modern black variation
CONFIG_DIR="$HOME/.config/waybar/themes/ml4w-modern"
STYLE_FILE="$CONFIG_DIR/black/style.css"

# Start waybar with config and black theme
waybar -c "$CONFIG_DIR/config" -s "$STYLE_FILE" &