return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		lazy = true,
		config = function()
			-- This is where you modify the settings for lsp-zero
			-- Note: autocompletion settings will not take effect

			require("lsp-zero.settings").preset({})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippent engine
			{ "L3MON4D3/LuaSnip" },
			-- Snippet
			{ "rafamadriz/friendly-snippets" },

			-- Cmp's
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" }, -- buffer completions
			{ "hrsh7th/cmp-path" }, -- path completions
			{ "saadparwaiz1/cmp_luasnip" },

			-- Use lspkind
			{ "onsails/lspkind.nvim" },
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			-- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
			-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

			require("lsp-zero.cmp").extend()
			require("luasnip/loaders/from_vscode").lazy_load()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local cmp_action = require("lsp-zero.cmp").action()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "buffer", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 2 },
				},
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
					["<C-e>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp_action.tab_complete(),
					["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = require("lspkind").cmp_format({
						mode = "symbol_text", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
						symbol_map = {
							TypeParameter = "",
						},
						before = require("tailwindcss-colorizer-cmp").formatter,
					}),
				},
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "jay-babu/mason-null-ls.nvim" },
			{ "jose-elias-alvarez/typescript.nvim" },
		},
		config = function()
			-- This is where all the LSP shenanigans will live

			local lsp = require("lsp-zero")

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)

			lsp.ensure_installed({
				-- Replace these with whatever servers you want to install
				"html",
				"cssls",
				"emmet_ls",
				"tailwindcss",
				"cssmodules_ls",
				"tsserver",

				"marksman",
				"sqlls",

				"clangd",
				"rust_analyzer",
				"lua_ls",
				"intelephense",
				"pyright",

				"dockerls",
				"docker_compose_language_service",
				"bashls",
				"jsonls",
				"yamlls",
			})

			-- Enable format on save
			lsp.format_on_save({
				format_opts = {
					async = false,
					timeout_ms = 10000,
				},
				servers = {
					["jsonls"] = { "json", "jsonc" },
					["clangd"] = { "c", "cpp" },
					["null-ls"] = {
						"html",
						"css",
						"scss",
						"json",
						"jsonc",
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
						"php",
						"lua",
					},
				},
			})

			-- Lsp Config
			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
			require("lspconfig").emmet_ls.setup({
				filetypes = {
					"astro",
					"css",
					"eruby",
					"html",
					"htmldjango",
					"javascriptreact",
					"less",
					"pug",
					"sass",
					"scss",
					"svelte",
					"typescriptreact",
					"vue",
					"php",
				},
			})
			require("lspconfig").intelephense.setup({
				single_file_support = true,
			})
			-- Skip server to make sure Custom LSP config / tools work
			lsp.skip_server_setup({ "tsserver" })
			lsp.setup()

			-- Custom LSP config / tools
			require("typescript").setup({
				server = {
					on_init = function(client)
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentFormattingRangeProvider = false
					end,
					on_attach = function(client, bufnr)
						-- You can find more commands in the documentation:
						-- https://github.com/jose-elias-alvarez/typescript.nvim#commands

						vim.keymap.set("n", "<leader>ci", "<cmd>TypescriptAddMissingImports<cr>", { buffer = bufnr })
					end,
				},
			})

			-- Null ls
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- Replace these with the tools you have installed
					null_ls.builtins.formatting.prettier.with({
						extra_args = {
							"--no-semi",
							"--single-quote",
							"--jsx-single-quote",
						},
					}),
					null_ls.builtins.formatting.stylua,
				},
			})

			require("mason-null-ls").setup({
				ensure_installed = nil,
				automatic_installation = true, -- You can still set this to `true`
				handlers = {
					-- Here you can add functions to register sources.
					-- See https://github.com/jay-babu/mason-null-ls.nvim#handlers-usage
					--
					-- If left empty, mason-null-ls will  use a "default handler"
					-- to register all sources
				},
			})
		end,
	},

	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		-- optionally, override the default options:
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
}
