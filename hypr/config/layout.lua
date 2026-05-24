-- -----------------------------------------------------
-- Layouts & Interaction Settings (Updated for New Gesture API)
-- -----------------------------------------------------

hl.config({
    general = {
        layout = "dwindle",
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        -- Customize your scrolling behavior here
    },

    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles = true,
        pass_mouse_when_bound = false,
    },
})

-- -----------------------------------------------------
-- New 1:1 Trackpad Gestures (Hyprland 0.51+)
-- -----------------------------------------------------

-- Swiping 3 fingers horizontally switches workspaces 1:1
hl.gesture({ 
    fingers = 3, 
    direction = "horizontal", 
    action = "workspace" 
})
