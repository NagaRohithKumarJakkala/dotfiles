#!/bin/bash

SERVICE="hypridle"

case "$1" in
    status)
        if pgrep -x "$SERVICE" >/dev/null; then
            echo '{"text":"","class":"active","tooltip":"Screen locking active\nLeft: Deactivate"}'
        else
            echo '{"text":"","class":"notactive","tooltip":"Screen locking deactivated\nLeft: Activate"}'
        fi
        ;;

    toggle)
        if pgrep -x "$SERVICE" >/dev/null; then
            pkill -x "$SERVICE"
        else
            hypridle >/dev/null 2>&1 &
        fi
        ;;

    *)
        echo "Usage: $0 {status|toggle}"
        exit 1
        ;;
esac
