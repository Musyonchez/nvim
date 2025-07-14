-- File: ~/.config/nvim/lua/plugins/editor/telescope.lua
--
-- This module configures Telescope, the fuzzy finder.

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5", -- Pin to a specific version for stability
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- This extension provides a better UI for selection prompts
    {
      "nvim-telescope/telescope-ui-select.nvim",
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      -- Default settings for Telescope
      defaults = {
        -- Default layout is a floating window in the center
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        -- Default key mappings in Telescope's normal mode
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<esc>"] = actions.close,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          },
        },
        -- Use ripgrep for searching if available
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim", -- Remove leading whitespace
        },
      },
      -- Configure Telescope extensions
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })

    -- Load the extensions
    telescope.load_extension("ui-select")

    -- Define keymaps for Telescope
    -- These will be picked up by which-key.nvim
    local map = vim.keymap.set
    -- Find files
    map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
    -- Find text in current buffer
    map("n", "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in Buffer" })
    -- Find text in all files (live grep)
    map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find in Files (Grep)" })
    -- Find git files
    map("n", "<leader>gf", "<cmd>Telescope git_files<cr>", { desc = "Find Git Files" })
    -- Find help tags
    map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help Tags" })
    -- Find buffers
    map("n", "<leader>fo", "<cmd>Telescope buffers<cr>", { desc = "Find Open Buffers" })
    -- Find recent files
    map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find Recent Files" })
  end,
}
