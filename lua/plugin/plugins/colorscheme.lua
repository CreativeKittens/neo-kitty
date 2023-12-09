-- Colorscheme
return {
	"catppuccin/nvim",
	priority = 9999,
	config = function(_, opts)
		require("catppuccin").setup(opts)

		-- setup must be called before loading
		vim.cmd.colorscheme("catppuccin")
	end,
	opts = {
		flavour = "mocha", -- latte, frappe, macchiato, mocha
		background = {
			light = "latte",
			dark = "mocha",
		},
		transparent_background = false,
		show_end_of_buffer = false,
		term_colors = true,
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
			types = { "bold" },
			functions = { "bold" },
		},
		integrations = {
			harpoon = true,
			neotree = true,
			gitsigns = true,
			treesitter = true,
			telescope = true,
			indent_blankline = {
				enabled = true,
				colored_indent_levels = false,
			},
			treesitter_context = true,
			notify = true,
			ts_rainbow2 = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
				},
			},
			barbecue = {
				dim_dirname = true,
				bold_basename = true,
				dim_context = false,
			},
		},
	},
}
