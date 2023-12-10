-- Telescope
return {
	"nvim-telescope/telescope.nvim",
	branch = false,
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
	keys = function()
		local root = require("core.util").get_root()

		return {
			{
				"<leader>f",
				function()
					require("telescope.builtin").find_files({ cwd = root, search_dirs = { root } })
				end,
				silent = true,
			},
			{
				"<leader>g",
				function()
					require("telescope.builtin").find_files({ cwd = root, search_dirs = { root } })
				end,
				silent = true,
			},
			{
				"<leader>Fg",
				function()
					require("telescope.builtin").git_files({ cwd = root, search_dirs = { root } })
				end,
				silent = true,
			},
			{
				"<leader>Ft",
				function()
					require("telescope.builtin").buffers({ cwd = root, search_dirs = { root } })
				end,
				silent = true,
			},
			{
				"<leader>Fb",
				function()
					require("telescope.builtin").git_branches({ cwd = root, search_dirs = { root } })
				end,
				silent = true,
			},
		}
	end,
	opts = function()
		local actions = require("telescope.actions")

		return {
			defaults = {
				prompt_prefix = "  ",
				selection_caret = "  ",
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,

						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,

						["<C-c>"] = actions.close,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,

						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = "nop",

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-l>"] = actions.complete_tag,
						["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
					},

					n = {
						["q"] = actions.close,
						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = "nop",

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["H"] = actions.move_to_top,
						["M"] = actions.move_to_middle,
						["L"] = actions.move_to_bottom,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["?"] = actions.which_key,
					},
				},
			},
			pickers = {
				find_files = {
					theme = "dropdown",
					hidden = true,
				},
				live_grep = {
					theme = "dropdown",
					hidden = true,
				},
				buffers = {
					theme = "dropdown",
				},
				git_branches = {
					theme = "dropdown",
				},
			},
		}
	end,
}
