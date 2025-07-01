-- File: ~/.config/nvim/lua/plugins/completion/copilot.lua
--
-- This module configures GitHub Copilot for AI code completion.

return {
  "zbirenbaum/copilot.lua",
  -- Load on command or insert mode
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      -- The panel is the UI that shows multiple suggestions.
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>", -- ALT+Enter
        },
        layout = {
          position = "bottom", -- "bottom", "right"
          ratio = 0.4,
        },
      },
      -- The suggestion module handles the inline "ghost text".
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>", -- Accept suggestion (ALT+l)
          accept_word = false,
          accept_line = false,
          next = "<M-]>", -- Next suggestion
          prev = "<M-[>", -- Previous suggestion
          dismiss = "<M-h>", -- Dismiss suggestion (ALT+h)
        },
      },
      -- Filetypes to disable copilot for.
      -- We disable it for git-related and markdown files by default.
      filetypes = {
        gitcommit = false,
        gitrebase = false,
        markdown = false,
        help = false,
        ["*"] = true, -- Enable for all other filetypes
      },
    })
  end,
}
