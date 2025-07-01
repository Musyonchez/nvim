-- File: ~/.config/nvim/lua/config/autocmds.lua
--
-- This module defines global autocommands for automated actions.
-- We use autocmd groups to keep them organized and prevent duplication.

-- Helper function to create an autocommand group
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-----------------------------------------------------------
-- General UI & Editing Enhancements
-----------------------------------------------------------

-- Highlight the yanked text for a short period.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("HighlightYank"),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

-- When entering a terminal buffer, enter insert mode.
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("EnterTerm"),
  pattern = "*",
  command = "startinsert",
  desc = "Start in insert mode in terminal buffers",
})

-- Automatically resize splits when the vim window is resized.
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("ResizeSplits"),
  pattern = "*",
  command = "tabdo wincmd =",
  desc = "Auto resize splits on window resize"
})

-- Go to the last location when opening a file.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("LastLocation"),
  pattern = "*",
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lnum = mark[1]
    local win_height = vim.api.nvim_win_get_height(0)
    if lnum > 0 and lnum <= vim.api.nvim_buf_line_count(args.buf) and lnum > win_height then
      vim.api.nvim_win_set_cursor(0, mark)
      vim.cmd("normal! zt")
    end
  end,
  desc = "Jump to last location when opening a file",
})

-----------------------------------------------------------
-- Filetype-Specific Settings
-----------------------------------------------------------
-- We will put more specific autocmds in the `after/ftplugin` files,
-- but here are a few global examples.

-- Auto-create an undodir for new files
-- Although we set the undodir in options, the directory must exist.
local undodir = vim.opt.undodir:get()[1]
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

