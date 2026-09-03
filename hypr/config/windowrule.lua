hl.window_rule({
    name  = "brave-tile",
    match = { class = "^(Brave-browser)$" },
    tile  = true,
})

hl.window_rule({
    name = "scrcpy",
    match = {class = "^(scrcpy)$"},
    float= true
}
)

hl.window_rule({
    name  = "simple-floats",
    match = { class = "^(blueman-manager)$|^(nm-connection-editor)$|^(qalculate-gtk)$" },
    float = true,
})

hl.window_rule({
    name  = "pip-rules",
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    pin   = true,
    move  = "69.5% 4%",
})

hl.window_rule({
    name   = "pavucontrol-rules",
    match  = { class = ".*org.pulseaudio.pavucontrol.*" },
    float  = true,
    size   = "700 600",
    center = true,
    pin    = true,
})

hl.window_rule({
    name  = "ml4w-calendar-rules",
    match = { class = "com.ml4w.calendar" },
    float = true,
    move  = "100%-w-16 66",
    pin   = true,
    size  = "400 400",
})


hl.window_rule({
    name   = "blueman-manager-rules",
    match  = { class = "blueman-manager" },
    float  = true,
    size   = "800 600",
    center = true,
})

hl.window_rule({
    name  = "nwg-tools-rules",
    match = { class = "(nwg-look|nwg-displays)" },
    float = true,
    size  = "700 600",
    move  = "10% 20%",
    pin   = true,
})

hl.window_rule({
    name   = "mission-center-rules",
    match  = { class = "io.missioncenter.MissionCenter" },
    float  = true,
    pin    = true,
    center = true,
    size   = "900 600",
})

hl.window_rule({
    name   = "mission-center-prefs-rules",
    match  = {
        class = "missioncenter",
        title = "^(Preferences)$"
    },
    float  = true,
    pin    = true,
    center = true,
})

hl.window_rule({
    name   = "gnome-calculator-rules",
    match  = { class = "org.gnome.Calculator" },
    float  = true,
    size   = "700 600",
    center = true,
})

hl.window_rule({
    name  = "smile-emoji-rules",
    match = { class = "it.mijorus.smile" },
    float = true,
    pin   = true,
    move  = "100%-w-40 90",
})

hl.window_rule({
    name   = "hyprland-share-picker-rules",
    match  = { class = "hyprland-share-picker" },
    float  = true,
    pin    = true,
    center = true,
    size   = "600 400",
})

hl.window_rule({
    name   = "pw-center",
    match  = { class = "hyprpwcenter" },
    float  = true,
    pin    = true,
    center = true,
    size   = "900 600",
})

hl.window_rule({
    name   = "general-floating-rules",
    match  = { class = "(dotfiles-floating|ml4w.dotfiles.floating)" },
    float  = true,
    size   = "1000 700",
    center = true,
    pin    = true,
})


hl.layer_rule({
    match = { namespace = "swaync-control-center" },
    blur = false,
    ignore_alpha = 0,
})

hl.layer_rule({
    match = { namespace = "swaync-notification-window" },
    blur = false,
    ignore_alpha = 0,
})
-- hl.layer_rule({
--     match = { namespace = "thunderbird" },
--     blur = false,
--     ignore_alpha = 0,
-- })

