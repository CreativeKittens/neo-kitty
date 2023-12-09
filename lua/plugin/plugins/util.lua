return {
	-- Indent blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = function()
			--[[ local highlight = { ]]
			--[[ 	"RainbowRed", ]]
			--[[ 	"RainbowYellow", ]]
			--[[ 	"RainbowBlue", ]]
			--[[ 	"RainbowOrange", ]]
			--[[ 	"RainbowGreen", ]]
			--[[ 	"RainbowViolet", ]]
			--[[ 	"RainbowCyan", ]]
			--[[ } ]]
			return {
				exclude = {
					filetypes = {
						"help",
						"alpha",
						"dashboard",
						"neo-tree",
						"Trouble",
						"lazy",
						"mason",
					},
				},
				scope = {
					enabled = true,
				},
			}
		end,
	},

	-- Vim surround
	{
		"tpope/vim-surround",
	},

	-- Colorizer
	{
		"norcalli/nvim-colorizer.lua",
		main = "colorizer",
		opts = {
			"*",
			DEFAULT_OPTIONS = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = true, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes: foreground, background
				mode = "background", -- Set the display mode.
			},
		},
	},

	-- Autopairs
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6", --recomended as each new version will have breaking changes
		opts = {
			--Config goes here
		},
	},

	-- Noice
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					enabled = false,
				},
				signature = {
					enabled = false,
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			}, -- add any options here
		},
	},

	-- Vim iluminate
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				filetypes_denylist = {
					"toggleterm",
					"TelescopePrompt",
					"neo-tree",
					"NvimTree",
				},
			})
		end,
	},

	-- Unception
	{
		"samjwill/nvim-unception",
		init = function()
			-- Optional settings go here!
			vim.g.unception_open_buffer_in_new_tab = true
		end,
	},

	-- Fcitx
	{
		"lilydjwg/fcitx.vim",
	},
}
