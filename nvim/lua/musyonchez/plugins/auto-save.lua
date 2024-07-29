return {
	"pocco81/auto-save.nvim",
	event = { "InsertLeave", "TextChanged" },
	config = function()
		require("auto-save").setup({
			enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
			execution_message = {
				message = function() -- message to print on save
					return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
				end,
				dim = 0.18, -- dim the color of `message`
				cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
			},
			trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
			-- function that determines whether to save the current buffer or not
			-- return true: if buffer is ok to be saved
			-- return false: if it's not ok to be saved
			condition = function(buf)
				local fn = vim.fn
				local utils = require("auto-save.utils.data")

				if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
					return true -- met condition(s), can save
				end
				return false -- can't save
			end,
			write_all_buffers = false, -- write all buffers when the current one meets `condition`
			debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
			callbacks = { -- functions to be executed at different intervals
				enabling = nil, -- ran when enabling auto-save
				disabling = nil, -- ran when disabling auto-save
				before_asserting_save = nil, -- ran before checking `condition`
				before_saving = nil, -- ran before doing the actual save
				after_saving = nil, -- ran after doing the actual save
			},
		})
  --   -- not sure if the below code works but its better to have it than not =)
		-- -- Additional settings for interval-based autosave
		-- local auto_save = require("auto-save")
		--
		-- -- Function to check if the current mode is normal or visual
		-- local function is_normal_or_visual_mode()
		-- 	local mode = vim.api.nvim_get_mode().mode
		-- 	return mode == "n" or mode == "v"
		-- end
		--
		-- -- Timer callback function to trigger auto-save
		-- local function auto_save_callback()
		-- 	if is_normal_or_visual_mode() then
		-- 		-- Assuming auto-save.nvim provides a public API for saving
		-- 		-- You might need to adapt this part based on the actual API
		-- 		auto_save.save_current_buffer()
		-- 	end
		-- end
		--
		-- -- Setup the timer to call the auto-save callback every 5 seconds (5000 milliseconds)
		-- vim.defer_fn(auto_save_callback, 5000)
		--
		-- -- Adjust the timer interval as needed
	end,
}
