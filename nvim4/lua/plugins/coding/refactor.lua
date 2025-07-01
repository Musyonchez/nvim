-- File: ~/.config/nvim/lua/plugins/coding/refactor.lua
--
-- This module configures the refactoring UI.

return {
  "TheOdinProject/refactoring.nvim",
  -- Load on buffer open or when a command is run
  event = { "BufReadPost", "BufNewFile" },
  cmd = "Refactor",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- Optional, for a nicer UI
  },
  config = function()
    require("refactoring").setup({
      -- We will use the default settings, which are excellent.
      -- The plugin can use Telescope for its UI if available.
      -- To explicitly configure it:
      -- select_refactor_ui = "telescope",
    })

    -- === Keymaps ===
    -- Refactoring actions are typically performed on a selection in Visual mode.
    local map = vim.keymap.set

    -- The '<leader>r' group will be created by which-key
    -- Main refactor menu
    map("v", "<leader>rr", function() require("telescope").extensions.refactoring.refactors() end, { desc = "[R]efactor [R]emenu..." })

    -- Specific refactor actions (examples)
    -- These are context-dependent and may not be available for all languages/LSPs.
    map("v", "<leader>re", function() require("refactoring").refactor("Extract Function") end, { desc = "[R]efactor [E]xtract Function" })
    map("v", "<leader>rv", function() require("refactoring").refactor("Extract Variable") end, { desc = "[R]efactor [E]xtract [V]ariable" })

    -- You can also map it in normal mode to act on the node under the cursor
    map("n", "<leader>ri", function() require("refactoring").refactor("Inline Variable") end, { desc = "[R]efactor [I]nline Variable" })
  end,
}
