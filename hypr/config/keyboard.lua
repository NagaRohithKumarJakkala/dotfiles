-- -----------------------------------------------------
-- Keyboard & Input Layout
-- -----------------------------------------------------

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        numlock_by_default = true,
        mouse_refocus = false,

        -- For United States (Commented out)
        -- kb_layout = "us",
        -- kb_variant = "intl",
        -- kb_model = "pc105",
        -- kb_options = "",

        follow_mouse = 1,
        
        touchpad = {
            -- for desktop
            -- natural_scroll = false,

            -- for laptop
            natural_scroll = true, -- 'yes' becomes boolean true in Lua
            middle_button_emulation = true,
            clickfinger_behavior = false,
            scroll_factor = 1.0, -- Touchpad scroll factor
        },
        
        -- sensitivity = 0, -- Pointer speed: -1.0 - 1.0
        sensitivity = 1, -- Pointer speed: -1.0 - 1.0
        scroll_factor = 1.5,
    },

    -- gestures = {
    --     workspace_swipe = true,
    -- },
})
