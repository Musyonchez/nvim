-- File: ~/.config/nvim/lua/plugins/completion/luasnip.lua
--
-- This module configures the LuaSnip snippet engine.

return {
  "L3MON4D3/LuaSnip",
  version = "v2.*", -- Pin to a specific major version for stability
  -- Follow the dependency chain to ensure it's loaded with nvim-cmp
  dependencies = { "rafamadriz/friendly-snippets" },
  -- Load snippets on startup
  build = "make install_jsregexp",
  config = function()
    local luasnip = require("luasnip")

    -- Load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Keymaps for navigating snippets
    -- These are only active when you are in a snippet
    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true, desc = "Expand or jump to next snippet placeholder" })

    vim.keymap.set({ "i", "s" }, "<C-h>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true, desc = "Jump to previous snippet placeholder" })

    vim.keymap.set({"i", "s"}, "<C-e>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true, desc = "Cycle snippet choice" })
  end,
}
