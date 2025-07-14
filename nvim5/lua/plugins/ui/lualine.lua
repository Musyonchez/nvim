-- File: ~/.config/nvim/lua/plugins/ui/lualine.lua
--
-- This module configures the Lualine statusline plugin.

return {
  "nvim-lualine/lualine.nvim",
  -- Lualine requires nvim-web-devicons for filetype icons.
  -- lazy.nvim will automatically handle the dependency.
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Import our custom icons
    local icons = require("utils.icons")

    require("lualine").setup({
      options = {
        -- The theme for the statusline.
        -- 'auto' will automatically use the colors from the active colorscheme.
        -- We can also explicitly set it to 'tokyonight'.
        theme = "tokyonight",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "dashboard", "nvim-tree" },
          winbar = {},
        },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { { "branch", icon = icons.misc.Branch }, "diff" },
        lualine_c = { { "filename", path = 1 } }, -- path = 1 shows filename + parent dir
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { { "location", icon = icons.misc.Location } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { "nvim-tree", "toggleterm" }, -- Enable extensions for better integration
    })
  end,
}
