-- File: ~/.config/nvim/lua/plugins/editor/which-key.lua
--
-- This module configures which-key to provide a popup of keybindings.
--
return {
	"folke/which-key.nvim",
	-- Load on the first key press, or after startup is fully complete
	event = "VeryLazy",
	config = function()
		local which_key = require("which-key")
		-- Set up which-key with some custom options
		which_key.setup({
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				-- spelling = { enabled = true, suggestions = 20 }, -- See spelling suggestions
			},
			win = {
				border = "rounded", -- none, single, double, rounded, solid, shadow
				-- position = "top", -- bottom, top
			},
			layout = {
				spacing = 6, -- Increase spacing between columns
				align = "center", -- center, left, right
			},
			-- Don't show a popup for these keybindings
			-- notify = false,
		})

		-- Define keymap groups using the new spec format
		which_key.add({
			-- Set mode for all mappings
			mode = { "n", "v" },

			-- Find group
			{ "<leader>f", group = "Find" },
			{ "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },

			-- Buffer group
			{ "<leader>b", group = "Buffer" },
			{ "<leader>bc", "<cmd>bdelete<CR>", desc = "Close Buffer" },
			{ "<leader>bn", "<cmd>bnext<CR>", desc = "Next Buffer" },
			{ "<leader>bp", "<cmd>bprevious<CR>", desc = "Previous Buffer" },

			-- Window group
			{ "<leader>w", group = "Window" },
			{ "<leader>wc", "<cmd>close<cr>", desc = "Close Window" },
			{ "<leader>ws", "<cmd>split<cr>", desc = "Horizontal Split" },
			{ "<leader>wv", "<cmd>vsplit<cr>", desc = "Vertical Split" },

			-- Single mappings
			{ "<leader>q", "<cmd>q<cr>", desc = "Quit" },
		})
	end,
}
