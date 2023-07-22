return {
	"willothy/nvim-cokeline",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required for v0.4.0+
		"nvim-tree/nvim-web-devicons", -- If you want devicons
		"moll/vim-bbye",
	},
	keys = {
		{
			"<leader>bd",
			function()
				require("core.util").buf_kill("Bdelete")
			end,
		},
		{ "<S-h>", "<Plug>(cokeline-focus-prev)", { silent = true } },
		{ "<S-l>", "<Plug>(cokeline-focus-next)", { silent = true } },
		{ "<leader>h", "<Plug>(cokeline-switch-prev)", { silent = true } },
		{ "<leader>l", "<Plug>(cokeline-switch-next)", { silent = true } },
	},
	config = true,
	opts = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")

		local separator = {
			text = " ",
			truncation = { priority = 1 },
		}

		local dev_icon = {
			text = function(buffer)
				return " " .. buffer.devicon.icon
			end,
			fg = function(buffer)
				return buffer.devicon.color
			end,
		}

		local filename = {
			text = function(buffer)
				return (buffer.is_readonly and buffer.unique_prefix .. buffer.filename .. " 󰌾 ")
					or buffer.unique_prefix .. buffer.filename .. " "
			end,
			fg = function(buffer)
				return (buffer.is_readonly and mocha.overlay0) or (buffer.is_focused and mocha.text) or mocha.overlay0
			end,
			style = function(buffer)
				return buffer.is_focused and "bold"
			end,
		}

		local diagnostics_error = {
			text = function(buffer)
				return (buffer.diagnostics.errors ~= 0 and " ") or ""
			end,
			fg = mocha.red,
		}

		local diagnostics_warning = {
			text = function(buffer)
				return (buffer.diagnostics.warnings ~= 0 and "󱧡 ") or ""
			end,
			fg = mocha.yellow,
		}

		local diagnostics_info = {
			text = function(buffer)
				return (buffer.diagnostics.infos ~= 0 and "󰌵 ") or ""
			end,
			fg = mocha.blue,
		}

		local diagnostics_hint = {
			text = function(buffer)
				return (buffer.diagnostics.hints ~= 0 and "󰛨 ") or ""
			end,
			fg = mocha.green,
		}

		local modified_status = {
			text = function(buffer)
				return (buffer.is_modified and " " or "") or ""
			end,
			fg = mocha.peach,
		}

		local close_button = {
			text = " ",
			delete_buffer_on_left_click = true,
			fg = function(buffer)
				return buffer.is_focused and mocha.text or mocha.overlay0
			end,
		}

		return {
			show_if_buffers_are_at_least = 0,

			buffers = {
				filter_valid = function(buffer)
					return buffer.filename ~= "[No Name]"
				end,
			},

			default_hl = {
				bg = mocha.base,
			},
			components = {
				dev_icon,
				filename,
				modified_status,
				diagnostics_error,
				diagnostics_warning,
				diagnostics_info,
				diagnostics_hint,
				close_button,
				separator,
			},
			sidebar = {
				filetype = "neo-tree",
				components = {
					{
						text = " File Tree",
						style = "bold",
						fg = mocha.text,
						bg = mocha.base,
					},
				},
			},
		}
	end,
}
