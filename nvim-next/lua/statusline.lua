vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lualine/lualine.nvim",
})

local lualine = require("lualine")
local nvim_start_time = os.time()
local global_elapsed_time = "00:00:00"

-- Start a timer that updates every second (using modern vim.uv)
local timer = (vim.uv or vim.loop).new_timer()
timer:start(0, 1000, vim.schedule_wrap(function()
    local elapsed = os.time() - nvim_start_time
    local hours = math.floor(elapsed / 3600)
    local mins = math.floor((elapsed % 3600) / 60)
    local secs = elapsed % 60
    global_elapsed_time = string.format('%02d:%02d:%02d', hours, mins, secs)
    vim.cmd('redrawstatus') -- Refresh lualine
end))

-- Custom lualine component
local function global_timer_component()
    return global_elapsed_time
end

local colors = {
    blue = "#65D1FF",
    green = "#3EFFDC",
    violet = "#FF61EF",
    yellow = "#FFDA7B",
    red = "#FF4A4A",
    fg = "#c3ccdc",
    bg = "#112638",
    inactive_bg = "#2c3043",
}

local my_lualine_theme = {
    normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
    },
    insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
    },
    visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
    },
    command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
    },
    replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
    },
    inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
    },
}

-- Configure lualine with modified theme
lualine.setup({
    options = {
        theme = my_lualine_theme,
    },
    sections = {
        lualine_x = {
            { "encoding" },
            { "fileformat" },
            { "filetype" },
            { global_timer_component }
        },
    },
})
