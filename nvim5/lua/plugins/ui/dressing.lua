-- File: ~/.config/nvim/lua/plugins/ui/dressing.lua
--
-- This module improves the default UI for vim.ui.input and vim.ui.select.

return {
  "stevearc/dressing.nvim",
  -- Lazy-load on events that trigger the UI
  event = "VeryLazy",
  config = function()
    require("dressing").setup({
      -- Configure the backends to use for vim.ui.select() and vim.ui.input().
      -- The 'builtin' backend is a good choice for a simple, clean floating window.
      -- Other options include 'telescope', 'fzf', 'fzf_lua', 'nui'.
      select = {
        backend = { "builtin" },

        -- Configuration for the 'builtin' backend
        builtin = {
          -- These are the default values, shown for clarity
          preview_config = {
            border = "rounded",
            width = 0.8,
            height = 0.4,
          },
        },
      },

      -- Configuration for vim.ui.input().
      input = {
        -- Set to false to disable replacement of vim.ui.input()
        enabled = true,
        backend = { "builtin" },

        -- Configuration for the 'builtin' backend
        builtin = {
          -- These are the default values, shown for clarity
          border = "rounded",
          -- The relative width of the input window.
          relative = "editor",
          -- The initial mode of the input buffer.
          start_in_insert = true,
          -- These keys will be mapped to the actions in the cartouche's
          -- first line.
          mappings = {
            n = {
              ["<CR>"] = "Close",
              ["<Esc>"] = "Close",
            },
            i = {
              ["<CR>"] = "Close",
              ["<Esc>"] = "Close",
              ["<C-c>"] = "Abort",
            },
          },
        },
      },
    })
  end,
}
