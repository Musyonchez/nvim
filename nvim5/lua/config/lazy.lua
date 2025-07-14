-- File: ~/.config/nvim/lua/config/lazy.lua
--
-- This module bootstraps and configures the lazy.nvim plugin manager.

-- Get the path to lazy.nvim repository
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Clone lazy.nvim from GitHub if it's not already installed
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- Add lazy.nvim to the runtime path to make it accessible
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
-- The 'spec' property is the most important. It tells lazy.nvim where to find plugin definitions.
-- We're pointing it to the 'lua/plugins' directory.
-- lazy.nvim will automatically require any .lua file in this directory.
require("lazy").setup("plugins", {
  -- The directory where plugins will be installed.
  root = vim.fn.stdpath("data") .. "/lazy",

  -- Configuration for the lazy.nvim UI
  ui = {
    border = "rounded", -- Use rounded borders for the UI window
  },

  -- Automatically check for plugin updates
  checker = {
    enabled = true,
    notify = true, -- Notify when updates are available
  },

  -- Handle changes in plugin specifications
  change_detection = {
    enabled = true,
    notify = true, -- Notify when a change is detected and prompt to sync
  },

  -- Performance optimizations
  performance = {
    rtp = {
      -- Neovim's default plugins that we'll replace with alternatives
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
       -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
