-- File: ~/.config/nvim/lua/plugins/ui/dashboard.lua
--
-- This module configures the start screen/dashboard.

return {
  "glepnir/dashboard-nvim",
  event = "VimEnter", -- Lazy load on startup
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local icons = require("utils.icons")

    -- Define the dashboard configuration
    require("dashboard").setup({
      -- The theme of the dashboard.
      theme = "hyper",

      -- The header of the dashboard.
      header = {
        [[                               __                ]],
        [[  ____  __  _______  __  __   / /   ____   _____ ]],
        [[ / __ \/ / / / ___/ / / / /  / /   / __ \ / ___/ ]],
        [[/ /_/ / /_/ / /    / /_/ /  / /___/ /_/ // /__   ]],
        [[\____/\__,_/_/     \__, /  /_____/\____/ \___/   ]],
        [[                  /____/                         ]],
      },

      -- The main buttons in the center of the screen.
      -- The 'action' can be a command string or a lua function.
      -- The actions for Telescope and Session management are placeholders.
      -- They will work once we configure those plugins.
      center = {
        {
          icon = icons.dashboard.FindFile,
          desc = "Find File          ",
          key = "f",
          action = "Telescope find_files",
        },
        {
          icon = icons.dashboard.FindText,
          desc = "Find Text          ",
          key = "g",
          action = "Telescope live_grep",
        },
        {
          icon = icons.dashboard.RecentFiles,
          desc = "Recent Files       ",
          key = "r",
          action = "Telescope oldfiles",
        },
        {
          icon = icons.dashboard.RestoreSession,
          desc = "Restore Session    ",
          key = "s",
          action = 'lua require("persisted").load()',
        },
        {
          icon = icons.dashboard.Lazy,
          desc = "Lazy Manager       ",
          key = "l",
          action = "Lazy",
        },
        {
          icon = icons.dashboard.Quit,
          desc = "Quit Neovim        ",
          key = "q",
          action = "qa",
        },
      },

      -- The footer of the dashboard.
      footer = {
        "~ NeoVim, but personalized ~",
      },
    })
  end,
}
