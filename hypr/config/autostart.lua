-- -----------------------------------------------------
-- ___   __  __            __            __
-- / _ |__ __/ /____  ___ / /____ _____/ /_
-- / __ / // / __/ _ \(_-</ __/ _ `/ __/ __/
-- /_/ |_\_,_/\__/\___/___/\__/\_,_/_/  \__/
--
-- -----------------------------------------------------

hl.on("hyprland.start", function ()
    hl.exec_cmd("~/.config/waybar/launch.sh")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("~/.config/hypr/scripts/cleanup.sh")
    hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets,ssh,gpg")
    hl.exec_cmd("nm-applet --indicator &")
    hl.exec_cmd("blueman-applet &")
end)
