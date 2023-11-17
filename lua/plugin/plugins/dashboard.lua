return {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	opts = {
		theme = "hyper",
		config = {
			project = {
				enable = true,
				limit = 8,
				icon = "your icon",
				label = "",
				action = "Telescope find_files cwd=",
			},
			week_header = {
				enable = true,
			},
			shortcut = {
				{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
				{
					icon = " ",
					icon_hl = "@variable",
					desc = "Files",
					group = "Label",
					action = "Telescope find_files",
					key = "f",
				},
			},
		},
	},
}
