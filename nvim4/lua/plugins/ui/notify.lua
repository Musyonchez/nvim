-- File: ~/.config/nvim/lua/plugins/ui/notify.lua
--
-- This module configures the notification UI.

return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	config = function()
		local notify = require("notify")
		notify.setup({
			-- Enhanced animation
			stages = "fade_in_slide_out",
			background_colour = "#000000",
			timeout = 3000,
			level = 2,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			-- Enhanced rendering
			render = "wrapped-compact",
			-- Minimum width for notifications
			minimum_width = 50,
			-- Icons for different log levels
			icons = {
				ERROR = "",
				WARN = "",
				INFO = "",
				DEBUG = "",
				TRACE = "✎",
			},
			-- Enhanced positioning
			top_down = true,
			-- Animation FPS
			fps = 30,
			-- Add some nice styling
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
		})

		vim.notify = notify

		-- Add some useful keymaps for notifications
		vim.keymap.set("n", "<leader>un", function()
			notify.dismiss({ silent = true, pending = true })
		end, { desc = "Dismiss All Notifications" })

		-- Show notification history
		vim.keymap.set("n", "<leader>nh", function()
			require("telescope").extensions.notify.notify()
		end, { desc = "Show Notification History" })
	end,
}
