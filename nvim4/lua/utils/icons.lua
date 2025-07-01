-- File: ~/.config/nvim/lua/utils/icons.lua
--
-- This module provides a centralized place for icons used across the configuration.
-- Requires a Nerd Font to be installed and configured in the terminal.

return {
  diagnostics = {
    Error = "", -- NF nf-fa-times_circle
    Warn = "",  -- NF nf-fa-warning
    Info = "",  -- NF nf-fa-info_circle
    Hint = "",  -- NF nf-mdi-lightbulb_on_outline
  },
  git = {
    Added = "",    -- NF nf-fa-plus
    Modified = "", -- NF nf-fa-circle_o_notch
    Removed = "",   -- NF nf-fa-minus
  },
  misc = {
    Branch = "", -- NF nf-custom-git
    Location = "📍", -- NF nf-mdi-pin
  },
   dashboard = {
    FindFile = "",      -- NF nf-fa-search
    FindText = "",      -- NF nf-fa-scissors
    NewFile = "",       -- NF nf-fa-plus
    RecentFiles = "", -- NF nf-fa-list_alt
    RestoreSession = "󰑓", -- NF nf-mdi-history
    Lazy = "󰒇",         -- NF nf-mdi-package_variant_closed
    Quit = "",         -- NF nf-fa-power_off
  },
    ui = {
    Command = "",     -- NF nf-cod-terminal_command
    Search = "",      -- NF nf-fa-search
    Input = "",       -- NF nf-oct-keyboard
    Filter = "",      -- NF nf-fa-filter
  },
   nvim_tree = {
    Folder = {
      ArrowClosed = "", -- NF nf-fa-caret_right
      ArrowOpen = "",   -- NF nf-fa-caret_down
    },
  },
}
