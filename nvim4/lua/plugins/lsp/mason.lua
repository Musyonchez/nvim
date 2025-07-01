-- File: ~/.config/nvim/lua/plugins/lsp/mason.lua
--
-- This module sets up Mason, the package manager for LSPs,
-- and mason-lspconfig, the bridge between Mason and lspconfig.

-- File: lua/plugins/editor/mason.lua (or wherever you keep this file)

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		-- Setup Mason UI
		require("mason").setup({
			ui = {
				border = "rounded",
				width = 0.8,
				height = 0.8,
			},
		})

		-- Setup LSP bridge
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"pyright",
				"gopls",
				"rust_analyzer",
				"bashls",
				"dockerls",
				"jsonls",
				"yamlls",
				"marksman",
			},
			-- This is not needed, mason-lspconfig does this automatically
			-- automatic_installation = true,
		})
	end,
}
