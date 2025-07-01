-- File: ~/.config/nvim/lua/plugins/completion/nvim-cmp.lua
--
-- This module configures the nvim-cmp autocompletion engine.

return {
	"hrsh7th/nvim-cmp",
	-- Load nvim-cmp on InsertEnter event
	event = "InsertEnter",
	dependencies = {
		-- Snippet engine
		"L3MON4D3/LuaSnip",
		-- Provides snippet completion source for nvim-cmp
		"saadparwaiz1/cmp_luasnip",

		-- Completion sources
		"hrsh7th/cmp-nvim-lsp", -- For LSP completions
		"hrsh7th/cmp-buffer", -- For buffer text completions
		"hrsh7th/cmp-path", -- For file path completions
		"hrsh7th/cmp-cmdline", -- For command-line completions

		-- For nice icons in the completion menu
		"onsails/lspkind.nvim",

		-- Autopairs integration
		"windwp/nvim-autopairs",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		cmp.setup({
			-- Enable snippet support
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			-- Configure completion sources
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),

			-- Configure key mappings for the completion menu
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- Previous item
				["<C-j>"] = cmp.mapping.select_next_item(), -- Next item
				["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll backward in documentation
				["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll forward in documentation
				["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
				["<C-e>"] = cmp.mapping.abort(), -- Close completion menu
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
			}),

			-- Configure the appearance of the completion menu
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text", -- Show symbol and text
					maxwidth = 50, -- Truncate long descriptions
					ellipsis_char = "...",
				}),
			},

			-- Experimental features
			experimental = {
				ghost_text = true, -- Show virtual text for completions
			},
		})

		-- Setup for command-line completion
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "cmdline" },
			}),
		})

		-- Integrate nvim-autopairs with nvim-cmp
		-- This is the correct place for this integration code.
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
