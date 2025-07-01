-- File: ~/.config/nvim/lua/plugins/editor/comment.lua
--
-- This module configures smart commenting functionality.

return {
	"numToStr/Comment.nvim",
	-- Load this plugin on startup or when a file is opened
	event = "VeryLazy",
	config = function()
		require("Comment").setup({
			-- We are using the default configuration, which is excellent.
			-- You can add custom configurations here if needed.
			-- For example, to add a space after the comment marker:
			-- ---@type comment.setup_opts
			-- pre_hook = function(ctx)
			--   local U = require "Comment.utils"
			--
			--   local location = nil
			--   if ctx.ctype == U.ctype.block then
			--     location = require("ts_context_commentstring.utils").get_cursor_location()
			--   elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			--     location = require("ts_context_commentstring.utils").get_visual_start_location()
			--   end
			--
			--   return require("ts_context_commentstring.internal").calculate_commentstring({
			--     key = ctx.ctype,
			--     location = location,
			--   })
			-- end,
		})
	end,
}
