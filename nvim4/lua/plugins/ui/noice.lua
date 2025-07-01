-- File: ~/.config/nvim/lua/plugins/ui/noice.lua
--
-- This module configures the Noice UI plugin, which overhauls

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		local icons = require("utils.icons")
		require("noice").setup({
			lsp = {
				progress = {
					enabled = true,
					-- Add formatting for LSP progress
					format = "lsp_progress",
					format_done = "lsp_progress_done",
					throttle = 1000 / 30, -- frequency to update lsp progress message
					view = "mini",
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				-- Enhanced hover and signature help
				hover = {
					enabled = true,
					silent = false, -- set to true to not show a message if hover is not available
				},
				signature = {
					enabled = true,
					auto_open = {
						enabled = true,
						trigger = true, -- Automatically show signature help when typing a trigger character
						luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
						throttle = 50, -- Debounce lsp signature help request by 50ms
					},
				},
			},
			-- Fix for which-key compatibility
			messages = {
				enabled = true,
				view = "notify",
				view_error = "notify",
				view_warn = "notify",
				view_history = "messages",
				view_search = "virtualtext",
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				opts = {
					-- Position the command line popup higher to avoid conflicts
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
					-- Important: Set relative to editor to avoid which-key conflicts
					relative = "editor",
				},
				format = {
					cmdline = {
						pattern = "^:",
						icon = icons.ui.Command,
						lang = "vim",
						title = " Command ",
					},
					search_down = {
						kind = "search",
						pattern = "^/",
						icon = " " .. icons.ui.Search,
						lang = "regex",
						title = " Search ",
					},
					search_up = {
						kind = "search",
						pattern = "^%?",
						icon = " " .. icons.ui.Search,
						lang = "regex",
						title = " Search ",
					},
					filter = {
						pattern = "^:%s*!",
						icon = icons.ui.Filter,
						lang = "bash",
						title = " Shell ",
					},
					lua = {
						pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
						icon = "",
						lang = "lua",
						title = " Lua ",
					},
					help = {
						pattern = "^:%s*he?l?p?%s+",
						icon = "",
						title = " Help ",
					},
					input = {
						view = "cmdline_input",
						icon = icons.ui.Input,
						title = " Input ",
					},
				},
			},
			-- Enhanced message routing
			routes = {
				{
					-- Skip "written" messages
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
							{ find = "%d fewer lines" },
							{ find = "%d more lines" },
						},
					},
					opts = { skip = true },
				},
				{
					-- Skip search wrap messages
					filter = {
						event = "msg_show",
						any = {
							{ find = "search hit BOTTOM" },
							{ find = "search hit TOP" },
						},
					},
					opts = { skip = true },
				},
				{
					-- Show macro recording in a mini view
					filter = { event = "msg_showmode" },
					view = "mini",
				},
				{
					-- Route long messages to split
					filter = {
						event = "msg_show",
						min_height = 20,
					},
					view = "messages",
					opts = { stop = false },
				},
				{
					-- IMPORTANT: Route which-key messages to cmdline to avoid conflicts
					filter = {
						event = "msg_show",
						find = "which_key",
					},
					view = "cmdline",
				},
			},
			-- Enhanced views configuration
			views = {
				cmdline_popup = {
					position = {
						row = 5,
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = 8,
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
			},
		})
	end,
}
