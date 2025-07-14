-- File: ~/.config/nvim/lua/plugins/coding/debugger.lua
--
-- This module configures the Debug Adapter Protocol (DAP) for debugging.

return {
  "mfussenegger/nvim-dap",
  -- Load on command or when a specific file is opened
  cmd = { "DapContinue", "DapToggleBreakpoint" },
  ft = { "python", "go", "javascript", "typescript" },
  dependencies = {
    -- UI for the debugger
    "rcarriga/nvim-dap-ui",
    -- Installs debug adapters automatically
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Ensure debug adapters are installed via Mason
    require("mason-nvim-dap").setup({
      ensure_installed = {}, -- Adapters are managed in mason.lua
      automatic_installation = true,
      handlers = {}, -- Keep this empty unless you need custom handlers
    })

    -- === DAP-UI Configuration ===
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 1 },
          },
          size = 0.25,
          position = "bottom",
        },
      },
      -- Other UI settings
      floating = {
        max_height = nil,
        max_width = nil,
        border = "rounded",
      },
      render = {
        max_type_length = nil,
      },
    })

    -- Add listeners to automatically open/close the DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- === DAP Adapter and Configuration Definitions ===
    -- Node.js / JavaScript / TypeScript
    dap.adapters.node2 = {
      type = "executable",
      command = "node-debug2-adapter",
    }
    dap.configurations.javascript = {
      {
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "internalConsole",
      },
    }
    dap.configurations.typescript = dap.configurations.javascript

    -- Python
    dap.adapters.python = {
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        program = "${file}",
        console = "integratedTerminal",
      },
    }

    -- Go
    dap.adapters.delve = {
      type = "server",
      port = "${port}",
      executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
      },
    }
    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug test",
        request = "launch",
        program = "${file}",
      },
    }

    -- === Keymaps ===
    local map = vim.keymap.set
    -- The '<leader>d' group will be created by which-key
    map("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug: Toggle [B]reakpoint" })
    map("n", "<leader>dc", dap.continue, { desc = "[D]ebug: [C]ontinue" })
    map("n", "<leader>do", dap.step_over, { desc = "[D]ebug: Step [O]ver" })
    map("n", "<leader>di", dap.step_into, { desc = "[D]ebug: Step [I]nto" })
    map("n", "<leader>du", dap.step_out, { desc = "[D]ebug: Step O[u]t" })
    map("n", "<leader>dr", dap.repl.open, { desc = "[D]ebug: Open [R]EPL" })
    map("n", "<leader>dl", dap.run_last, { desc = "[D]ebug: [L]aunch Last" })
    map("n", "<leader>dt", dap.terminate, { desc = "[D]ebug: [T]erminate" })
  end,
}
