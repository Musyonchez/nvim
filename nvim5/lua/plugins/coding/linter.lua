-- File: ~/.config/nvim/lua/plugins/coding/linter.lua
--
-- This module configures code linting with nvim-lint.

return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",
	config = function()
		local lint = require("lint")

		-- Define the linters to use for each filetype.
		-- The key is the filetype and the value is a list of linter names.
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			python = { "flake8" },
			sh = { "shellcheck" },
			dockerfile = { "hadolint" },
			php = { "phpstan" },
		}

		-- Create an autocommand to run the linter on save and on buffer enter.
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			group = lint_augroup,
			callback = function(args)
				lint.try_lint(nil, { bufnr = args.buf })
			end,
			desc = "Run linter on buffer events",
		})

		-- Optional: Define keymaps for manual linting
		local map = vim.keymap.set
		map("n", "<leader>cl", function()
			lint.try_lint()
		end, { desc = "Trigger linting" })
	end,
}
