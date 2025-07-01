-- File: ~/.config/nvim/lua/plugins/editor/todo-comments.lua
--
-- This module highlights and provides tools for managing TODO comments.

return {
  "folke/todo-comments.nvim",
  -- Load after other plugins, as it depends on them (like Telescope)
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({
      -- signs = true, -- Can be enabled to show a sign in the sign column
      -- sign_priority = 8, -- Lower priority than other signs like diagnostics
      keywords = {
        -- Define custom keywords and their appearance
        FIX = {
          icon = " ", -- icon for `FIX` keywords
          color = "error", -- can be a hex color or a highlight group
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- alternative keywords
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "CAUTION" } },
        PERF = { icon = " ", color = "performance", alt = { "OPTIM", "PERFORMANCE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      -- Highlighting options
      highlight = {
        -- The keyword that comes before the colon, e.g. "TODO:"
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg"
        -- The whole line of the comment
        line = false,
      },
      -- Search configuration
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- The pattern to search for.
        -- This is a Perl-compatible regex.
        pattern = [[\b(]] .. table.concat(require("todo-comments.config").get_keywords(), "|") .. [[)\b]],
      },
    })

    -- Define keymaps for listing TODOs
    local map = vim.keymap.set
    -- The '<leader]t' group will be automatically created by which-key
    map("n", "<leader>T", "<cmd>TodoTelescope<cr>", { desc = "List TODO comments" })
  end,
}
