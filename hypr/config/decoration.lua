-- -----------------------------------------------------
-- General window decoration
-- name: "Default"
-- -----------------------------------------------------

hl.config({
    decoration = {
        rounding = 5,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,

        blur = {
            enabled = false,
            size = 6,
            passes = 4,
            new_optimizations = true, -- 'on' becomes boolean true in Lua
            ignore_opacity = true,
            xray = true,
            -- Note: 'blurls' is handled via window rules in modern Hyprland, e.g.:
            -- hl.windowrulev2("blur", "class:^(waybar)$")
        },

        shadow = {
            enabled = false,
            range = 30,
            render_power = 3,
            color = 0x66000000, -- Hex color notation maps natively
        },
    },
})
