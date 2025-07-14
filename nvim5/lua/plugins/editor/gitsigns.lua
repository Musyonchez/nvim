-- File: ~/.config/nvim/lua/plugins/editor/gitsigns.lua
--
-- This module configures Git integration and diff markers.

return {
  "lewis6991/gitsigns.nvim",
  -- Load this plugin when a buffer is opened
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local icons = require("utils.icons")
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      -- Configure the signs to use our custom icons
      signs = {
        add = { text = icons.git.Added },
        change = { text = icons.git.Modified },
        delete = { text = icons.git.Removed },
        topdelete = { text = icons.git.Removed },
        changedelete = { text = icons.git.Modified },
      },
      -- Highlight the line number for git changes
      numhl = true,
      -- Do not highlight the entire line, as it can be distracting
      linehl = false,
      -- A callback function to run when gitsigns attaches to a buffer
      on_attach = function(bufnr)
        local map = function(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Hunk Navigation
        map("n", "]h", function() gitsigns.next_hunk({ navigation_message = false }) end, { desc = "Next Hunk" })
        map("n", "[h", function() gitsigns.prev_hunk({ navigation_message = false }) end, { desc = "Previous Hunk" })

        -- Actions
        -- The '<leader>h' group will be automatically created by which-key
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[H]unk [S]tage" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })
        map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "[H]unk [S]tage" })
        map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "[H]unk [R]eset" })

        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "[H]unk [S]tage Buffer" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "[H]unk [R]eset Buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[H]unk [P]review" })
        map("n", "<leader>hb", gitsigns.blame_line, { desc = "[H]unk [B]lame Line" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "[H]unk [D]iff This" })
      end,
    })
  end,
}
