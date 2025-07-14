-- File: lua/plugins/lsp/mason-tools.lua

return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- Make sure it runs AFTER mason.nvim
	dependencies = { "williamboman/mason.nvim" },
	-- It's better to run this on startup to ensure tools are available
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Formatters
				"stylua",
				"prettierd",
				"black",
				"isort",
				"gofumpt",
				"shfmt",
				"php-cs-fixer",

				-- Linters
				"eslint_d",
				"flake8",
				"shellcheck",
				"hadolint",
				"phpstan",

				-- Debug Adapters
				"debugpy",
				"delve",
			},
			-- You can turn this on if you want tools to update automatically
			auto_update = false,
			-- This is the key. It will run on startup and install missing tools.
			run_on_start = true,
		})
	end,
}
