-- File: ~/.config/nvim/lua/plugins/coding/formatter.lua
--
-- This module configures code formatting with conform.nvim.

return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	opts = {
		-- A map of filetypes to formatters.
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = { "isort", "black" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			json = { "prettierd" },
			yaml = { "prettierd" },
			markdown = { "prettierd" },
			go = { "gofumpt", "goimports" },
			sh = { "shfmt" },
			php = { "php_cs_fixer" },
		},

		-- Enable format on save.
		-- This will be run async.
		format_on_save = {
			-- I recommend these options. See :help conform.format for details.
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		-- Define keymaps for manual formatting
		local map = vim.keymap.set
		map("n", "<leader>cf", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "Format file" })

		-- You can also format a selection in visual mode
		map("v", "<leader>cf", "<cmd>ConformFormat<cr>", { desc = "Format selection" })
	end,
}
