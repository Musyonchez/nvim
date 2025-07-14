-- File: ~/.config/nvim/lua/plugins/editor/surround.lua
--
-- This module configures functionality to add, change, and delete surroundings.

return {
  "kylechui/nvim-surround",
  version = "*", -- Use the latest version
  -- This plugin is operator-based, so it should be available when needed.
  -- 'VeryLazy' is a good event to load it without impacting startup time.
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- The configuration is minimal as the defaults are great.
      -- You can add custom surroundings here if you wish.
      -- For example:
      -- surrounds = {
      --   ["s"] = {
      --     add = function()
      --       return { { " " }, { " " } }
      --     end,
      --   },
      -- },
    })
  end,
}
