-- File: ~/.config/nvim/lua/plugins/ui/bufferline.lua
--
-- This module configures the bufferline for a tab-like experience.

return {
  "akinsho/bufferline.nvim",
  version = "*", -- Pin to the latest version
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Import our custom icons
    local icons = require("utils.icons")

    require("bufferline").setup({
      options = {
        -- Use "buffers" to show all open buffers, or "tabs" for Neovim's tab-based workflow
        mode = "buffers",

        -- Use our theme's colors for a cohesive look
        themable = true,

        -- Show buffer numbers (ordinal, buffer_id, etc.)
        numbers = "ordinal",

        -- The command to run when closing a buffer (e.g., clicking the close icon)
        -- 'bdelete' is a good choice as it preserves window layout.
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",

        -- Separator style between buffer tabs
        -- Can be 'slant', 'slope', 'thick', 'thin', 'padded_slant'
        separator_style = "slant",

        -- Show the bufferline even if there is only one buffer
        always_show_bufferline = true,

        -- Show filetype icons
        show_buffer_icons = true,
        show_buffer_close_icon = true,
        show_close_icon = true,

        -- Custom icon for a modified buffer
        modified_icon = icons.git.Modified,

        -- Enable LSP diagnostics display in the bufferline
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local icon = icons.diagnostics[e] or ""
            s = s .. n .. icon .. " "
          end
          return s
        end,

        -- Add an offset to the bufferline to account for nvim-tree or other sidebars
        -- This is a smart function that detects if nvim-tree is open and adjusts.
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
            separator = true,
          },
        },
      },
    })

    -- Optional: Add keymaps for bufferline navigation.
    -- We will centralize these in which-key.lua later, but here's an example:
    -- local map = vim.keymap.set
    -- map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    -- map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
    -- map("n", "<leader>bc", "<Cmd>bdelete<CR>", { desc = "Close current buffer" })
  end,
}
