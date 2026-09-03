hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        numlock_by_default = true,
        mouse_refocus = false,
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
            middle_button_emulation = true,
            clickfinger_behavior = false,
            scroll_factor = 1.0,
        },
        sensitivity = 1,
        scroll_factor = 1.5,
    },

})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.gesture({
    fingers = 3,
    direction = "down",
    action = "special",
    workspace_name = "scratchpad",
    disable_inhibit = true })

