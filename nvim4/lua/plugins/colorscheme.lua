-- File: ~/.config/nvim/lua/plugins/colorscheme.lua
--
-- This module configures the colorscheme for Neovim.

return {
  "folke/tokyonight.nvim",
  lazy = false, -- Make sure the colorscheme is loaded on startup
  priority = 1000, -- Make sure to load this before all the other start plugins
  config = function()
    -- Configuration options for tokyonight
    require("tokyonight").setup({
      style = "storm", -- The theme variant to use: "storm", "night", "day"
      transparent = true, -- Enable this to see your terminal's background
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        -- Style to be applied to different syntax groups
        -- You can use any of the style keywords: "bold", "italic", "underline", "inverse"
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, such as NvimTree
        floats = "transparent", -- style for floating windows
      },
    })

    -- Load the colorscheme
    vim.cmd.colorscheme("tokyonight")
  end,
}
