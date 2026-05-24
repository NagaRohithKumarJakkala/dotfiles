-- -----------------------------------------------------
-- Window Rules (v0.55+ Optimized Lua Syntax)
-- -----------------------------------------------------

-- SwayNC Control Center
hl.layer_rule({
    match = { namespace = "swaync-control-center" },
    blur = false,
    ignore_alpha = 0,
    -- ignore_zero = true, -- Uncomment this line if you want to use it
})

-- SwayNC Notification Window
hl.layer_rule({
    match = { namespace = "swaync-notification-window" },
    blur = false,
    ignore_alpha = 0,
})
-- hl.layerrule("ignorezero", "swaync-notification-window")

-- -----------------------------------------------------
-- Environment Variables
-- -----------------------------------------------------

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- QT
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- Toolkit & Browser
hl.env("GDK_SCALE", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("XCURSOR_SIZE", "24")

-- Ozone / Electron (Keeps Chromium apps smooth natively on Intel Xe)
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
