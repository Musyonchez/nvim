-- Neovim options configuration
local opt = vim.opt

-- General
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.laststatus = 3
opt.list = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 4
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false
opt.fillchars = {
  foldopen = "▼",
  foldclose = "▶",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Line numbers
opt.number = true
opt.numberwidth = 2

-- Folding
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Search
opt.hlsearch = true
opt.incsearch = true

-- Backup and swap
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Performance
opt.lazyredraw = true
opt.ttyfast = true

-- Diff mode
opt.diffopt:append("linematch:60")

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end