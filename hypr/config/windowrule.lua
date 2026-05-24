-- If the API uses a table structure (most common for modern Hypr Lua configs):
hl.windowrules = {
    { "tile", "class:^(Brave-browser)$" },
    { "float", "class:^(org.pulseaudio.pavucontrol)$" },
    { "float", "class:^(blueman-manager)$" },
    { "float", "class:^(nm-connection-editor)$" },
    { "float", "class:^(qalculate-gtk)$" },
    
    -- Picture-in-Picture Rules
    { "float", "title:^(Picture-in-Picture)$" },
    { "pin", "title:^(Picture-in-Picture)$" },
    { "move 69.5% 4%", "title:^(Picture-in-Picture)$" },
    
    -- Fullscreen Idle Inhibition
    { "idleinhibit fullscreen", "class:.*" },
    -- Pavucontrol
    { "float", "class:.*org.pulseaudio.pavucontrol.*" },
    { "size 700 600", "class:.*org.pulseaudio.pavucontrol.*" },
    { "center", "class:.*org.pulseaudio.pavucontrol.*" },
    { "pin", "class:.*org.pulseaudio.pavucontrol.*" },

    -- Waypaper
    { "float", "class:.*waypaper.*" },
    { "size 900 700", "class:.*waypaper.*" },
    { "center", "class:.*waypaper.*" },
    { "pin", "class:.*waypaper.*" },

    -- ML4W Calendar
    { "float", "class:com.ml4w.calendar" },
    { "move 100%-w-16 66", "class:com.ml4w.calendar" },
    { "pin", "class:com.ml4w.calendar" },
    { "size 400 400", "class:com.ml4w.calendar" },

    -- ML4W Sidebar
    { "float", "class:com.ml4w.sidebar" },
    { "move 100%-w-16 66", "class:com.ml4w.sidebar" },
    { "pin", "class:com.ml4w.sidebar" },
    { "size 400 740", "class:com.ml4w.sidebar" },

    -- ML4W Welcome App
    { "float", "class:com.ml4w.welcome" },
    { "size 700 600", "class:com.ml4w.welcome" },
    { "center", "class:com.ml4w.welcome" },
    { "pin", "class:com.ml4w.welcome" },

    -- ML4W Settings App
    { "float", "class:com.ml4w.settings" },
    { "size 800 600", "class:com.ml4w.settings" },
    { "move 10% 20%", "class:com.ml4w.settings" },

    -- Blueman Manager
    { "float", "class:blueman-manager" },
    { "size 800 600", "class:blueman-manager" },
    { "center", "class:blueman-manager" },

    -- nwg-look & nwg-displays
    { "float", "class:(nwg-look|nwg-displays)" },
    { "size 700 600", "class:(nwg-look|nwg-displays)" },
    { "move 10% 20%", "class:(nwg-look|nwg-displays)" },
    { "pin", "class:(nwg-look|nwg-displays)" },

    -- System Mission Center
    { "float", "class:io.missioncenter.MissionCenter" },
    { "pin", "class:io.missioncenter.MissionCenter" },
    { "center", "class:io.missioncenter.MissionCenter" },
    { "size 900 600", "class:io.missioncenter.MissionCenter" },

    -- System Mission Center Preference Window
    { "float", "class:missioncenter;title:^(Preferences)$" },
    { "pin", "class:missioncenter;title:^(Preferences)$" },
    { "center", "class:missioncenter;title:^(Preferences)$" },

    -- Gnome Calculator
    { "float", "class:org.gnome.Calculator" },
    { "size 700 600", "class:org.gnome.Calculator" },
    { "center", "class:org.gnome.Calculator" },

    -- Emoji Picker Smile
    { "float", "class:it.mijorus.smile" },
    { "pin", "class:it.mijorus.smile" },
    { "move 100%-w-40 90", "class:it.mijorus.smile" },

    -- Hyprland Share Picker
    { "float", "class:hyprland-share-picker" },
    { "pin", "class:hyprland-share-picker" },
    { "center", "class:hyprland-share-picker" },
    { "size 600 400", "class:hyprland-share-picker" },

    -- General & Ghostty Floating
    { "float", "class:(dotfiles-floating|ml4w.dotfiles.floating)" },
    { "size 1000 700", "class:(dotfiles-floating|ml4w.dotfiles.floating)" },
    { "center", "class:(dotfiles-floating|ml4w.dotfiles.floating)" },
    { "pin", "class:(dotfiles-floating|ml4w.dotfiles.floating)"}
}
