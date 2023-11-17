-- Neotree
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	event = "VimEnter",
	name = "neo-tree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = require("core.util").get_root() })
			end,
			silent = true,
		},
		{
			"<leader>E",
			function()
				require("neo-tree.command").execute({ focus = true, dir = require("core.util").get_root() })
			end,
			silent = true,
		},
	},
	opts = function()
		local function getTelescopeOpts(state, path)
			local root_path = require("core.util").get_root(path)
			return {
				cwd = root_path,
				search_dirs = { root_path },
				attach_mappings = function(prompt_bufnr, map)
					local actions = require("telescope.actions")
					actions.select_default:replace(function()
						actions.close(prompt_bufnr)
						local action_state = require("telescope.actions.state")
						local selection = action_state.get_selected_entry()
						local filename = selection.filename
						if filename == nil then
							filename = selection[1]
						end
						-- any way to open the file without triggering auto-close event of neo-tree?
						require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
					end)
					return true
				end,
			}
		end

		return {
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
			filesystem = {
				components = {
					harpoon_index = function(config, node, state)
						local Marked = require("harpoon.mark")
						local path = node:get_id()
						local succuss, index = pcall(Marked.get_index_of, path)
						if succuss and index and index > 0 then
							return {
								text = string.format(" ⥤ %d", index), -- <-- Add your favorite harpoon like arrow here
								highlight = config.highlight or "NeoTreeDirectoryIcon",
							}
						else
							return {}
						end
					end,
				},
				renderers = {
					file = {
						{ "icon" },
						{ "name", use_git_status_colors = true },
						{ "harpoon_index" }, --> This is what actually adds the component in where you want it
						{ "diagnostics" },
						{ "git_status", highlight = "NeoTreeDimText" },
					},
				},
				use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
				follow_current_file = true,
				filtered_items = {
					hide_by_name = {
						"node_modules",
					},
				},
				hijack_netrw_behavior = "open_current",
			},
			buffers = {
				follow_current_file = true, -- This will find and focus the file in the active buffer every
			},
			default_component_configs = {
				container = {
					enable_character_fade = true,
				},
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "󰷏",
					default = "",
					highlight = "NeoTreeFileIcon",
				},
				modified = {
					symbol = "",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						added = "A",
						modified = "M",
						deleted = "D",
						renamed = "R",
						untracked = "u",
						ignored = "I",
						unstaged = "U",
						staged = "S",
						conflict = "C",
					},
				},
			},
			commands = {
				telescope_find = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					require("telescope.builtin").find_files(getTelescopeOpts(state, path))
				end,
				telescope_grep = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					require("telescope.builtin").live_grep(getTelescopeOpts(state, path))
				end,
			},
			window = {
				position = "left",
				width = 30,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["f"] = "telescope_find",
					["g"] = "telescope_grep",
					["<Tab>"] = {
						"toggle_node",
						nowait = false,
					},
					["<2-LeftMouse>"] = "open",
					["o"] = "open",
					["<esc>"] = "revert_preview",
					["P"] = { "toggle_preview", config = { use_float = true } },
					["l"] = "focus_preview",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["t"] = "open_tabnew",
					["w"] = "open_with_window_picker",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					["a"] = {
						"add",
						config = {
							show_path = "none",
						},
					},
					["A"] = "add_directory",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function(file_path)
						--auto close
						require("neo-tree").close_all()
					end,
				},
				{
					event = "neo_tree_window_after_open",
					handler = function(args)
						if args.position == "left" or args.position == "right" then
							vim.cmd("wincmd =")
						end
					end,
				},
				{
					event = "neo_tree_window_after_close",
					handler = function(args)
						if args.position == "left" or args.position == "right" then
							vim.cmd("wincmd =")
						end
					end,
				},
			},
		}
	end,
}
