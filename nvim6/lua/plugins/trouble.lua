return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local trouble = require("trouble")

    trouble.setup({
      icons = false,
      fold_open = "v",
      fold_closed = ">",
      indent_lines = false,
      signs = {
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
      },
      use_diagnostic_signs = false
    })

  end,
}