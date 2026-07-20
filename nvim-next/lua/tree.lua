-- 1. Register and download dependencies and plugins
vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/windwp/nvim-ts-autotag",
})

-- 2. Configure autotag
require("nvim-ts-autotag").setup()

-- 3. Configure Treesitter
local treesitter = require("nvim-treesitter")

treesitter.setup({
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "prisma",
    "markdown",
    "markdown_inline",
    "svelte",
    "graphql",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
    "query",
    "vimdoc",
    "c",
    "cpp",
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-enter>",
      node_incremental = "<C-enter>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})
