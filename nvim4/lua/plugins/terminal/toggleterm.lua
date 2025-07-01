-- File: ~/.config/nvim/lua/plugins/terminal/toggleterm.lua
--
-- This module configures the integrated terminal manager.

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	-- Use keys to lazy-load, which is very efficient
	keys = {
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "[T]erminal [F]loat" },
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "[T]erminal [H]orizontal" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "[T]erminal [V]ertical" },
	},
	opts = {
		-- The size of the terminal window. Can be a number (lines/columns) or a float (percentage)
		size = function(term)
			if term.direction == "horizontal" then
				return 15 -- 15 lines
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4 -- 40% of the screen width
			end
			return 20 -- Default for float
		end,
		-- Use a consistent border for floating terminals
		float_opts = {
			border = "rounded",
		},
		-- Open the terminal in insert mode
		start_in_insert = true,
		-- When the terminal window is opened, it will seem to float above the editor
		shade_terminals = true,
		-- The terminal buffer will be automatically closed when the process exits
		close_on_exit = true,
		-- Use the shell configured in Neovim's options
		shell = vim.o.shell,
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		-- Define a custom function for a lazygit terminal
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			dir = vim.fn.getcwd(),
			direction = "float",
			hidden = true, -- Start hidden
			on_close = function(term)
				vim.cmd("doautocmd User LazyGitExited")
			end,
		})

		function _LAZYGIT_TOGGLE()
			lazygit:toggle()
		end

		-- Add a keymap for the lazygit terminal
		vim.keymap.set("n", "<leader>gg", _LAZYGIT_TOGGLE, { desc = "Toggle [G]it [G]UI (LazyGit)" })
	end,
}
