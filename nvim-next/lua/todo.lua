vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/folke/todo-comments.nvim",
})

-- 2. Configure todo-comments
local todo_comments = require("todo-comments")

todo_comments.setup()

-- 3. Set keymaps
local keymap = vim.keymap

keymap.set("n", "]t", function()
  todo_comments.jump_next()
end, { desc = "Next todo comment" })

keymap.set("n", "[t", function()
  todo_comments.jump_prev()
end, { desc = "Previous todo comment" })
