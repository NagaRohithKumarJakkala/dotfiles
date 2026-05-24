return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- -- Setup capabilities for nvim-cmp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		--
		-- -- Example: Set up a language server (e.g., lua_ls)
		-- require("lspconfig").lua_ls.setup({
		--   capabilities = capabilities,
		-- })
		--
		--
		-- require("lspconfig").clangd.setup({
		--   capabilities = capabilities,
		-- })
		--
		-- -- Example: Set up another server (e.g., pyright for Python)
		-- require("lspconfig").pyright.setup({
		--   capabilities = capabilities,
		-- })
		--
		-- require("lspconfig").rust_analyzer.setup({
		--   capabilities = capabilities,
		-- })
		--
		-- require("lspconfig").gopls.setup({
		--   capabilities = capabilities,
		-- })

		-- init.lua or lua/lsp-config.lua
		-- Neovim 0.11 Native LSP Setup

		-- LSP settings and capabilities
		-- local lspconfig = require('lspconfig')
		-- local capabilities = vim.lsp.protocol.make_client_capabilities()

		-- Enhanced capabilities for completion
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = { "documentation", "detail", "additionalTextEdits" },
		}

		-- Diagnostic configuration
		vim.diagnostic.config({
			virtual_text = {
				source = "if_many",
				prefix = "●",
			},
			float = {
				-- source = "always",
				source = true,
				border = "rounded",
			},
			-- signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚",
					[vim.diagnostic.severity.WARN] = "󰀪",
					[vim.diagnostic.severity.INFO] = "󰋽",
					[vim.diagnostic.severity.HINT] = "󰌶",
				},
			},
		})

		-- LSP keymaps function
		local function on_attach(client, bufnr)
			local opts = { buffer = bufnr, silent = true }

			-- Navigation
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

			-- Documentation
			-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

			-- Code actions
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, opts)

			-- Diagnostics
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

			-- Workspace
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
		end

		-- Language server configurations
		local servers = {
			-- Lua
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			},

			-- Python
			pyright = {
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
						},
					},
				},
			},

			-- TypeScript/JavaScript
			ts_ls = {
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			},

			-- Rust
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = {
							enable = true,
							command = "clippy",
							extraArgs = { "--no-deps" },
						},
					},
				},
			},

			-- C/C++
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
					"--query-driver=/usr/bin/clang",
				},
			},

			-- Go
			gopls = {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			},
		}

		-- Setup language servers
		for server, config in pairs(servers) do
			-- lspconfig[server].setup(vim.tbl_deep_extend("force", {
			vim.lsp.config[server] = vim.tbl_deep_extend("force", {
				on_attach = on_attach,
				capabilities = capabilities,
			}, config or {})
			vim.lsp.enable(server)
		end

		-- Auto-completion setup (built-in completion)
		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		-- Completion keymaps
		vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { silent = true })
		vim.keymap.set("i", "<Tab>", function()
			if vim.fn.pumvisible() == 1 then
				return "<C-n>"
			else
				return "<Tab>"
			end
		end, { expr = true })
		vim.keymap.set("i", "<S-Tab>", function()
			if vim.fn.pumvisible() == 1 then
				return "<C-p>"
			else
				return "<S-Tab>"
			end
		end, { expr = true })

		-- LSP progress indicator
		-- vim.api.nvim_create_autocmd("LspProgress", {
		--     callback = function(args)
		--         local client_name = vim.lsp.get_client_by_id(args.data.client_id).name
		--         vim.notify(string.format("[%s] %s", client_name, args.data.result.message or ""))
		--     end,
		-- })

		-- Automatically start LSP when entering supported filetypes
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "lua", "python", "javascript", "typescript", "rust", "c", "cpp", "go" },
			callback = function()
				vim.schedule(function()
					if vim.lsp.buf and type(vim.lsp.buf.code_lens_refresh) == "function" then
						vim.lsp.buf.code_lens_refresh()
					end
				end)
			end,
		})

		-- Signs for diagnostics
		-- local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
		-- for type, icon in pairs(signs) do
		--     local hl = "DiagnosticSign" .. type
		--     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		-- end
		--
		-- local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
		--
		-- for type, icon in pairs(signs) do
		--     local hl_name = "DiagnosticSign" .. type
		--     -- Ensure the highlight group exists and is linked or defined
		--     vim.api.nvim_set_hl(0, hl_name, { link = "Diagnostic" .. type })
		--
		--     -- This is the key part for setting the actual sign text for Neovim's diagnostics
		--     -- You define a global variable that Neovim's diagnostics will read
		--     vim.diagnostic.signs[type] = { text = icon, texthl = hl_name, numhl = hl_name }
		-- end
	end,
}
