-- File: ~/.config/nvim/lua/plugins/lsp/handlers.lua
--
-- This module defines the handlers and capabilities for the LSP client.

local M = {}

M.on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- A helper function for setting keymaps
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
	end

	-- Core LSP Keymaps
	map("gD", vim.lsp.buf.declaration, "Go to Declaration")
	map("gd", vim.lsp.buf.definition, "Go to Definition")
	map("K", vim.lsp.buf.hover, "Hover Documentation")
	map("gi", vim.lsp.buf.implementation, "Go to Implementation") -- Fixed typo: impementation
	map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

	-- References and Actions
	map("gr", "<cmd>Telescope lsp_references<cr>", "Go to References")
	map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
	map("<leader>rn", vim.lsp.buf.rename, "Rename")

	-- Diagnostics
	map("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics")
	map("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics")

	-- Apply formatting on save if the server supports it
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true }),
			buffer = bufnr,
			callback = function()
				-- vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
end

-- Function to get capabilities (called after cmp_nvim_lsp is loaded)
M.get_capabilities = function()
	local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if has_cmp then
		return cmp_nvim_lsp.default_capabilities()
	else
		return vim.lsp.protocol.make_client_capabilities()
	end
end

return M
