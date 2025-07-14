-- File: ~/.config/nvim/lua/plugins/editor/nvim-tree.lua
--
-- This module configures the nvim-tree file explorer.
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local icons = require("utils.icons")
		-- Disable netrw and other built-in file explorers
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		require("nvim-tree").setup({
			-- Do not open the tree when opening a directory
			hijack_directories = {
				enable = true,
			},
			-- Update the file explorer when the CWD changes
			update_cwd = true,
			-- Automatically update the tree when files are created/deleted/renamed
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			-- Git integration
			git = {
				enable = true,
				ignore = false,
			},
			-- Custom rendering for a clean look
			renderer = {
				group_empty = true,
				-- Add vertical indent lines
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = icons.nvim_tree.Folder.ArrowClosed,
							arrow_open = icons.nvim_tree.Folder.ArrowOpen,
						},
						git = {
							unstaged = icons.git.Modified,
							staged = icons.git.Added,
							unmerged = "",
							renamed = "",
							untracked = "",
							deleted = icons.git.Removed,
							ignored = "◌",
						},
					},
				},
			},
			-- General view settings
			view = {
				width = 30,
				side = "left",
				relativenumber = true,
			},
			-- Actions for interacting with the tree
			actions = {
				open_file = {
					-- Quits the tree window when you open a file
					quit_on_open = false,
				},
			},
		})
		-- Define keymaps for nvim-tree
		local map = vim.keymap.set
		map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
		map("n", "<leader>fe", "<cmd>NvimTreeFindFile<cr>", { desc = "Find in File Explorer" })
	end,
}
