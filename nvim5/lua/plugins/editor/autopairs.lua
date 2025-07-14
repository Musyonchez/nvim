-- File: ~/.config/nvim/lua/plugins/editor/autopairs.lua
--
-- This module configures auto-closing of brackets, quotes, etc.

return {
  "windwp/nvim-autopairs",
  -- Load this plugin on the first time we enter insert mode
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      -- This is a key feature. It uses treesitter to check the context
      -- before inserting a pair. For example, it will not auto-pair
      -- a quote if you are inside a string.
      check_ts = true,

      -- This enhances the Treesitter check by defining which nodes to
      -- ignore when checking for pairing.
      ts_config = {
        lua = { "string" },
        javascript = { "string", "template_string" },
        -- You can add more filetypes here as needed
      },

      -- By default, the plugin is smart and works out of the box.
      -- For example, it enables "fast wrap" which allows you to select
      -- text in visual mode and press an opening bracket to wrap the
      -- selection.
    })

    -- Integration with nvim-cmp.
    -- This is important to prevent autopairs from conflicting with
    -- the completion plugin. We will set this up when we configure
    -- nvim-cmp itself, but it's good to be aware of.
    -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    -- local cmp = require("cmp")
    -- cmp.event:on(
    --   "confirm_done",
    --   cmp_autopairs.on_confirm_done()
    -- )
  end,
}
