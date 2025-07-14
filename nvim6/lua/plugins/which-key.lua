return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local which_key = require("which-key")

		which_key.setup({
			plugins = {
				marks = true,
				registers = true,
			},
			win = {
				border = "rounded",
			},
			layout = {
				spacing = 6,
				align = "center",
			},
		})

		which_key.add({
			mode = { "n", "v" },

			{ "<leader>t", group = "Telescope" },
			{ "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>tr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
			{ "<leader>ts", "<cmd>Telescope live_grep<cr>", desc = "Find String" },
			{ "<leader>tc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
			{ "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
			{ "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
			{ "<leader>tm", "<cmd>Telescope marks<cr>", desc = "Marks" },
			{ "<leader>tk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },

			{ "<leader>b", group = "Buffer" },
			{ "<leader>bc", "<cmd>bdelete<CR>", desc = "Close Buffer" },
			{ "<leader>bn", "<cmd>bnext<CR>", desc = "Next Buffer" },
			{ "<leader>bp", "<cmd>bprevious<CR>", desc = "Previous Buffer" },
			{ "<leader>bb", "<cmd>BufferLinePick<CR>", desc = "Pick Buffer" },
			{ "<leader>bd", "<cmd>BufferLinePickClose<CR>", desc = "Pick Buffer to Close" },
			{ "<leader>bP", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bD", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-pinned Buffers" },

			{ "<leader>w", group = "Window" },
			{ "<leader>wc", "<cmd>close<cr>", desc = "Close Window" },
			{ "<leader>ws", "<cmd>split<cr>", desc = "Horizontal Split" },
			{ "<leader>wv", "<cmd>vsplit<cr>", desc = "Vertical Split" },
			{ "<leader>wh", "<C-w>h", desc = "Go to Left Window" },
			{ "<leader>wj", "<C-w>j", desc = "Go to Lower Window" },
			{ "<leader>wk", "<C-w>k", desc = "Go to Upper Window" },
			{ "<leader>wl", "<C-w>l", desc = "Go to Right Window" },

			{ "<leader>l", group = "LSP" },
			{ "<leader>lr", ":LspRestart<CR>", desc = "Restart LSP" },
			{ "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "Format" },
			{ "<leader>li", "<cmd>LspInfo<CR>", desc = "LSP Info" },

			{ "<leader>c", group = "Code" },
			{ "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Actions" },
			{ "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
			{ "<leader>cf", "<cmd>lua require('conform').format()<CR>", desc = "Format" },

			{ "<leader>d", group = "Diagnostics" },
			{ "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Line Diagnostics" },
			{ "<leader>dq", "<cmd>lua vim.diagnostic.setqflist()<CR>", desc = "Quickfix List" },

			{ "<leader>g", group = "Git" },
			{ "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<CR>", desc = "Stage Hunk" },
			{ "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", desc = "Reset Hunk" },
			{ "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<CR>", desc = "Preview Hunk" },
			{ "<leader>gb", "<cmd>lua require('gitsigns').blame_line()<CR>", desc = "Blame Line" },
			{ "<leader>gS", "<cmd>lua require('gitsigns').stage_buffer()<CR>", desc = "Stage Buffer" },
			{ "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", desc = "Undo Stage Hunk" },
			{ "<leader>gR", "<cmd>lua require('gitsigns').reset_buffer()<CR>", desc = "Reset Buffer" },
			{ "<leader>gd", "<cmd>lua require('gitsigns').diffthis()<CR>", desc = "Diff This" },
			{
				"<leader>gt",
				"<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>",
				desc = "Toggle Line Blame",
			},

			{ "<leader>e", group = "Explorer" },
			{ "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
			{ "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Find File in Explorer" },
			{ "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse Explorer" },
			{ "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh Explorer" },
			{ "<leader>q", "<cmd>q<cr>", desc = "Quit" },
			{ "<leader>Q", "<cmd>q!<cr>", desc = "Force Quit" },
			{ "<leader>s", "<cmd>w<cr>", desc = "Save" },
			{ "<leader>z", "<cmd>x<cr>", desc = "Save and Quit" },
			{ "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", desc = "Search and Replace" },

			{ "<leader>x", group = "Trouble" },
			{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
			{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics" },
			{ "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Quickfix List" },
			{ "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Location List" },
			{ "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Todo Trouble" },

			{ "<leader><tab>", group = "Tabs" },
			{ "<leader><tab><tab>", "<cmd>tabnew<cr>", desc = "New Tab" },
			{ "<leader><tab>]", "<cmd>tabnext<cr>", desc = "Next Tab" },
			{ "<leader><tab>[", "<cmd>tabprevious<cr>", desc = "Previous Tab" },
			{ "<leader><tab>d", "<cmd>tabclose<cr>", desc = "Close Tab" },
			{ "<leader><tab>f", "<cmd>tabfirst<cr>", desc = "First Tab" },
			{ "<leader><tab>l", "<cmd>tablast<cr>", desc = "Last Tab" },
		})
	end,
}

