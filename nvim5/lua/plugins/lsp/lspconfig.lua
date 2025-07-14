-- File: ~/.config/nvim/lua/plugins/lsp/lspconfig.lua
--
-- This module iterates over the servers installed by Mason
-- and sets them up using lspconfig.

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- NOW the plugins are loaded, so we can safely require them
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local handlers = require("plugins.lsp.handlers")

		-- Get the list of installed servers
		local servers = mason_lspconfig.get_installed_servers()

		-- Loop through the installed servers and set them up
		for _, server_name in ipairs(servers) do
			local server_opts = {
				on_attach = handlers.on_attach,
				capabilities = handlers.get_capabilities(),
			}

			-- Example of custom settings for a specific server (lua_ls)
			if server_name == "lua_ls" then
				server_opts.settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
					},
				}
			end

			-- Setup the server with the combined options
			lspconfig[server_name].setup(server_opts)
		end
	end,
}
