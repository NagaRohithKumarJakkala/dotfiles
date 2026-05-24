#!/bin/bash

MONS=($(hyprctl monitors | grep "Monitor" | awk '{print $2}'))

PRIMARY=${MONS[0]}

for MON in "${MONS[@]}"; do
    if [ "$MON" != "$PRIMARY" ]; then
        hyprctl keyword monitor "$PRIMARY,preferred,0x0,1"
        hyprctl keyword monitor "$MON,preferred,0x0,1,mirror,$PRIMARY"
    fi
done
