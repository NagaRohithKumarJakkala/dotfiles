vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/akinsho/bufferline.nvim",
})

-- 2. Configure bufferline
require("bufferline").setup({
  options = {
    mode = "tabs",
    separator_style = "slant",
  },
})
