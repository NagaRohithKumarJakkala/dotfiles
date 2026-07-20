vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/nosduco/remote-sshfs.nvim",
})

require("todo-comments").setup()
require("remote-sshfs").setup({})

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    path_display = { "smart" },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
})

-- Load Telescope extensions
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "remote-sshfs")

-- 4. Set keymaps
local keymap = vim.keymap
local builtin = require("telescope.builtin")
local sshfs_api = require("remote-sshfs.api")
local sshfs_connections = require("remote-sshfs.connections")

-- Remote SSHFS Management Keymaps
keymap.set("n", "<leader>rc", sshfs_api.connect, { desc = "SSHFS Connect" })
keymap.set("n", "<leader>rd", sshfs_api.disconnect, { desc = "SSHFS Disconnect" })
keymap.set("n", "<leader>re", sshfs_api.edit, { desc = "SSHFS Edit Config" })

-- Dynamic Telescope Keymaps (Host-connection aware)
keymap.set("n", "<leader>ff", function()
  if sshfs_connections.is_connected() then
    sshfs_api.find_files()
  else
    builtin.find_files()
  end
end, { desc = "Fuzzy find files (local/remote)" })

keymap.set("n", "<leader>fs", function()
  if sshfs_connections.is_connected() then
    sshfs_api.live_grep()
  else
    builtin.live_grep()
  end
end, { desc = "Find string in cwd (local/remote)" })

-- General Telescope Keymaps
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
