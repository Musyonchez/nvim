-- File: ~/.config/nvim/lua/config/options.lua
--
-- This module sets the core Neovim options for a modern editing experience.
-- Each option is commented to explain its purpose.

-- For convenience, create a local variable for vim.opt
local opt = vim.opt

-----------------------------------------------------------
-- General Editor Behavior
-----------------------------------------------------------
opt.mouse = "a" -- Enable mouse support in all modes
opt.clipboard = "unnamedplus" -- Use system clipboard for copy/paste
opt.swapfile = false -- Disable the swap file
opt.backup = false -- Disable backup files
opt.undofile = true -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- Set undo directory

-- Command line height
opt.cmdheight = 1 -- More space for displaying messages
opt.pumheight = 10 -- Pop-up menu height

-- Performance
opt.updatetime = 300 -- Faster completion and cursor hold events (for gitsigns)
opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete
opt.showmode = false -- Don't show the mode, lualine will handle it

-----------------------------------------------------------
-- User Interface
-----------------------------------------------------------
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.cursorline = true -- Highlight the current line
opt.signcolumn = "yes" -- Always show the sign column to avoid jitter
opt.wrap = false -- Do not wrap lines
opt.scrolloff = 8 -- Keep 8 lines of context around the cursor
opt.sidescrolloff = 8 -- Keep 8 columns of context around the cursor
opt.list = true -- Show invisible characters
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-----------------------------------------------------------
-- Indentation & Tabs
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2 -- Number of visual spaces per tab
opt.softtabstop = 2 -- Number of spaces for tab key
opt.shiftwidth = 2 -- Number of spaces for auto-indent
opt.smartindent = true -- Smarter indentation for new lines
opt.autoindent = true -- Copy indent from current line when starting a new line

-----------------------------------------------------------
-- Search
-----------------------------------------------------------
opt.hlsearch = true -- Highlight all matches on search
opt.incsearch = true -- Show search results incrementally
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search pattern contains uppercase letters

-----------------------------------------------------------
-- Window Splits
-----------------------------------------------------------
opt.splitbelow = true -- Force new horizontal splits to go below current
opt.splitright = true -- Force new vertical splits to go to the right of current

-----------------------------------------------------------
-- Folding
-----------------------------------------------------------
opt.foldmethod = "expr" -- Use treesitter for folding
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 99 -- Start with all folds open
