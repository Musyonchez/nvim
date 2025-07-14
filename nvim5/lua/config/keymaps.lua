-- File: ~/.config/nvim/lua/config/keymaps.lua
--
-- This module defines global keybindings and shortcuts.
-- Plugin-specific keymaps are defined in their respective plugin files.

-- Set the leader key.
-- This must be done before any mappings are defined.
-- The most common and ergonomic choice is the space bar.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For convenience, create a reference to the keymap function
local map = vim.keymap.set

-- Options for keymaps
-- silent:      Don't show the command in the command line.
-- noremap:     Non-recursive mapping.
local opts = { noremap = true, silent = true }

-----------------------------------------------------------
-- General & Navigation
-----------------------------------------------------------

-- Remap for dealing with word wrap
-- When a line is wrapped, j and k should move to the next visual line
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrow keys
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":resize -2<CR>", opts)
map("n", "<C-Right>", ":resize +2<CR>", opts)

-- Better buffer navigation
-- Note: bufferline.nvim will provide a more robust solution,
-- but these are good fallbacks.
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-----------------------------------------------------------
-- Editing Enhancements
-----------------------------------------------------------

-- Move selected lines up and down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Better terminal navigation
-- This allows using CTRL+hjkl to navigate back to Neovim windows
-- from a terminal buffer. We will set this up properly in toggleterm.lua.
-- For now, we are just defining the global behavior.
map("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

-----------------------------------------------------------
-- Quality of Life
-----------------------------------------------------------

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Fast saving
map("n", "<C-s>", "<cmd>w<CR>", { silent = true, noremap = true, desc = "Save file" })

-----------------------------------------------------------
-- Clipboard & Deletion Behavior
-----------------------------------------------------------

-- Prevent deleted/overwritten text from entering the clipboard.
-- This makes 'd', 'c', 'x', and pasting over a selection use a
-- "black hole" register instead of the system clipboard.
map("n", "d", '"_d', opts)
map("n", "c", '"_c', opts)
map("n", "x", '"_x', opts)
map("n", "X", '"_X', opts)
map("v", "p", '"_dP', { desc = "Paste over selection without yanking" })
