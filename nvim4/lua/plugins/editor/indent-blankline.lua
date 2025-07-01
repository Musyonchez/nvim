-- File: ~/.config/nvim/lua/plugins/editor/indent-blankline.lua
--
-- This module configures visual indentation guides.

return {
  "lukas-reineke/indent-blankline.nvim",
  -- Set the main function to be called for setup
  main = "ibl",
  -- Load after other UI elements and filetype plugins
  event = "VeryLazy",
  opts = {
    -- The character to use for the indent guide.
    -- A simple bar '|' is a good default. Some fonts have special box drawing characters.
    -- A space ' ' will show blank indent lines.
    indent = {
      char = "│",
      tab_char = "│",
    },
    -- The scope highlighting shows the current context (e.g., the function you're in).
    scope = {
      enabled = true,
      show_start = true,
      show_end = true,
    },
    -- Configure which filetypes to exclude.
    -- We exclude help files and the dashboard for a cleaner look.
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "trouble",
        "lazy",
        "mason",
      },
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)
  end,
}
