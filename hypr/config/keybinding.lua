local mainMod = "SUPER"
local HYPRSCRIPTS = os.getenv("HOME") .. "/.config/hypr/scripts"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind("ALT + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus --new-window"))

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("bash ~/Templates/repeat.sh"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("bash ~/Templates/repeat1.sh"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("quickshell --path ~/.config/quickshell/device.qml"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("quickshell --path ~/Dev/quickshell/main.qml"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("thunderbird"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("gtk-launch whatsapp-firefox"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("firefox mail.google.com"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("gtk-launch youtube-firefox"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("gtk-launch spotify-firefox"))
-- hl.bind(mainMod .. " + N", hl.dsp.exec_cmd( "swaync-client -t -sw"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd( "~/.config/hypr/scripts/control-center.sh"))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd( "rofimoji"))

hl.bind(mainMod .. " + G", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + X", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Mouse Binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Keyboard Resizing & Group Management
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100,   y = 0,    relative = true }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -100, y = 0,    relative = true }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,    y = 100,  relative = true }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,    y = -100, relative = true }))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.group.toggle())
hl.bind("ALT+TAB", hl.dsp.group.next())
hl.bind("ALT+SHIFT+TAB", hl.dsp.group.prev())
hl.bind(mainMod .. " + K", hl.dsp.layout( "swapsplit" ))
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "down" }))

-- Window Cycling (Repeatable using hlbinder/hlbinde equivalents)


-- Actions & Scripts
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("quickshell --path ~/.config/quickshell/screenshot.qml"))
-- hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh --instant-area"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots/"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("scrcpy -d"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("scrcpy --tcpip"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("wlogout -b 5"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -replace -i"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("hyprlauncher"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/waybar/launch.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("killall waybar"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/loadconfig.sh"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/cliphist.sh"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("quickshell --path ~/.config/quickshell/peek.qml"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/hyprshade.sh"))
hl.bind(mainMod .. " + ALT + G", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/gamemode.sh"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end


hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"))
hl.bind(mainMod .. " + SHIFT + Tab",   hl.dsp.focus({ workspace = "m-1" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))


-- Fn Media & Hardware Controls
-- hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +5%"))
-- hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 5%-"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"))
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))


hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("gnome-calculator"))
hl.bind("XF86ScreenSaver", hl.dsp.exec_cmd("hyprlock"))


hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +5"))
hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 5-"))
