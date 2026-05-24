-- In your plugins setup file (e.g., ~/.config/nvim/lua/plugins/init.lua or similar)
return{
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  event = 'BufReadPost',
  config = function()
    -- Basic fold settings
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Keymaps
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

    -- Choose ONE of the following setups ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

    -- Option 1: For use with coc.nvim (comment out if not using coc)
    -- require('ufo').setup()

    -- Option 2: For native LSP with foldingRange capability
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.foldingRange = {
    --   dynamicRegistration = false,
    --   lineFoldingOnly = true
    -- }
    -- local lspconfig = require('lspconfig')
    -- local servers = { 'gopls', 'clangd' } -- manually specify your LSPs here
    -- for _, server in ipairs(servers) do
    --   lspconfig[server].setup({
    --     capabilities = capabilities,
    --     -- Add other settings here
    --   })
    -- end
    -- require('ufo').setup()

    -- Option 3: Use treesitter and indent as providers
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end
    })

    -- Option 4: Disable all providers (not recommended)
    -- require('ufo').setup({
    --   provider_selector = function(_, _, _)
    --     return ''
    --   end
    -- })
  end
}
