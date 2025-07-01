-- File: ~/.config/nvim/lua/plugins/editor/trouble.lua
--
-- This module configures the Trouble plugin for diagnostics and quickfix lists.

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Lazy load on command or keymap
  cmd = { "TroubleToggle", "Trouble" },
  opts = {
    -- Use our custom icons
    icons = {
      -- You can override the default icons here if you wish
      -- For example, use our centralized icons
      error = require("utils.icons").diagnostics.Error,
      warning = require("utils.icons").diagnostics.Warn,
      info = require("utils.icons").diagnostics.Info,
      hint = require("utils.icons").diagnostics.Hint,
    },
    -- Use a floating window for the Trouble UI
    mode = "float", -- "float", "split", "workspace"
    -- Automatically open the list when diagnostics are first detected
    auto_open = false,
    -- Automatically close the list when there are no more diagnostics
    auto_close = true,
    -- Automatically jump to the first item when opening the list
    auto_jump = { "lsp_definitions" },
    -- Other visual and behavioral settings
    padding = true,
    indent_lines = true,
    win = {
      -- position = "bottom",
      size = {
        height = 10,
        -- width = 0.8
      }
    }
  },
  config = function(_, opts)
    require("trouble").setup(opts)

    -- Define keymaps for Trouble
    local map = vim.keymap.set
    -- The '<leader>x' group will be automatically created by which-key
    map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Diagnostics" })
    map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" })
    map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics" })
    map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List" })
    map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List" })
    map("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", { desc = "LSP References" })

    -- A keymap to jump to the next/previous trouble item
    map("n", "]t", function() require("trouble").next({ skip_groups = true, jump = true }) end, { desc = "Next Trouble Item" })
    map("n", "[t", function() require("trouble").previous({ skip_groups = true, jump = true }) end, { desc = "Previous Trouble Item" })
  end,
}
