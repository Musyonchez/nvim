local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
vim.opt.rtp:prepend(lazypath)

  checker = require("lazy").setup({ { import = "musyonchez.plugins" }, { import = "musyonchez.plugins.lsp" } }, {
{
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
