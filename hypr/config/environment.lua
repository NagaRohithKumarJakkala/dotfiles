-- -----------------------------------------------------
-- Environment Variables
-- -----------------------------------------------------

-- Force Firefox to use native Wayland
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Desktop Environment Specs
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GTK_USE_PORTAL", "1")
