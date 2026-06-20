#!/bin/bash

if pgrep -f "quickshell --path .*mp.qml" >/dev/null; then
    pkill -f "quickshell --path .*mp.qml"
else
    quickshell --path ~/.config/quickshell/mp.qml &
fi
