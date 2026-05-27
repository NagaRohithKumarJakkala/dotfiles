-- Brave Browser
hl.window_rule({
    name  = "brave-tile",
    match = { class = "^(Brave-browser)$" },
    tile  = true,
})

-- Simple Float Rules
hl.window_rule({
    name  = "simple-floats",
    match = { class = "^(blueman-manager)$|^(nm-connection-editor)$|^(qalculate-gtk)$" },
    float = true,
})

-- Picture-in-Picture Rules
hl.window_rule({
    name  = "pip-rules",
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    pin   = true,
    move  = "69.5% 4%",
})

-- Pavucontrol
hl.window_rule({
    name   = "pavucontrol-rules",
    match  = { class = ".*org.pulseaudio.pavucontrol.*" },
    float  = true,
    size   = "700 600",
    center = true,
    pin    = true,
})

-- Waypaper
hl.window_rule({
    name   = "waypaper-rules",
    match  = { class = ".*waypaper.*" },
    float  = true,
    size   = "900 700",
    center = true,
    pin    = true,
})

-- ML4W Calendar
hl.window_rule({
    name  = "ml4w-calendar-rules",
    match = { class = "com.ml4w.calendar" },
    float = true,
    move  = "100%-w-16 66",
    pin   = true,
    size  = "400 400",
})

-- ML4W Sidebar
hl.window_rule({
    name  = "ml4w-sidebar-rules",
    match = { class = "com.ml4w.sidebar" },
    float = true,
    move  = "100%-w-16 66",
    pin   = true,
    size  = "400 740",
})

-- ML4W Welcome App
hl.window_rule({
    name   = "ml4w-welcome-rules",
    match  = { class = "com.ml4w.welcome" },
    float  = true,
    size   = "700 600",
    center = true,
    pin    = true,
})

-- ML4W Settings App
hl.window_rule({
    name  = "ml4w-settings-rules",
    match = { class = "com.ml4w.settings" },
    float = true,
    size  = "800 600",
    move  = "10% 20%",
})

-- Blueman Manager
hl.window_rule({
    name   = "blueman-manager-rules",
    match  = { class = "blueman-manager" },
    float  = true,
    size   = "800 600",
    center = true,
})

-- nwg-look & nwg-displays
hl.window_rule({
    name  = "nwg-tools-rules",
    match = { class = "(nwg-look|nwg-displays)" },
    float = true,
    size  = "700 600",
    move  = "10% 20%",
    pin   = true,
})

-- System Mission Center
hl.window_rule({
    name   = "mission-center-rules",
    match  = { class = "io.missioncenter.MissionCenter" },
    float  = true,
    pin    = true,
    center = true,
    size   = "900 600",
})

-- System Mission Center Preference Window
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

-- Gnome Calculator
hl.window_rule({
    name   = "gnome-calculator-rules",
    match  = { class = "org.gnome.Calculator" },
    float  = true,
    size   = "700 600",
    center = true,
})

-- Emoji Picker Smile
hl.window_rule({
    name  = "smile-emoji-rules",
    match = { class = "it.mijorus.smile" },
    float = true,
    pin   = true,
    move  = "100%-w-40 90",
})

-- Hyprland Share Picker
hl.window_rule({
    name   = "hyprland-share-picker-rules",
    match  = { class = "hyprland-share-picker" },
    float  = true,
    pin    = true,
    center = true,
    size   = "600 400",
})

-- General & Ghostty Floating
hl.window_rule({
    name   = "general-floating-rules",
    match  = { class = "(dotfiles-floating|ml4w.dotfiles.floating)" },
    float  = true,
    size   = "1000 700",
    center = true,
    pin    = true,
})
