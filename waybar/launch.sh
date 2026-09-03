#!/bin/bash

killall waybar 2>/dev/null || true
sleep 0.3

CONFIG_DIR="$HOME/.config/waybar"
STYLE_FILE="$CONFIG_DIR/style.css"

waybar -c "$CONFIG_DIR/config" -s "$STYLE_FILE" &
