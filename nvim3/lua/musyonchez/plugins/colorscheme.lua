return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			-- Dark palette tuned for beauty and eye comfort, based on your original colors
			local bg = "#1A2239" -- darker than your bg_dark, solid dark blue
			local bg_dark = "#121829" -- very dark panel/floating background
			local bg_highlight = "#2A3A71" -- subtle dark blue highlight for selection
			local bg_search = "#FF6E5B" -- warm coral red for search highlight, not too harsh
			local bg_visual = "#3B4DB0" -- mild blue selection color
			local fg = "#AFC1DB" -- soft pastel blue for main text (light but not glaring)
			local fg_dark = "#6B7C9D" -- medium muted blue-gray for comments and gutters
			local fg_gutter = "#556987" -- darker blue-gray for line numbers/signs
			local border = "#3F5375" -- soft pastel blue border for UI elements

			require("tokyonight").setup({
				style = "night", -- use official night style base
				transparent = false,
				terminal_colors = true,
				styles = {
					comments = { italic = true, fg = "#5C6B8C" }, -- muted blue-gray italics for comments
					keywords = { bold = true, fg = "#FF7B6A" }, -- warm coral for keywords, bright but soft
					functions = { fg = "#74A2FF", bold = true }, -- vibrant but not harsh blue for functions
					variables = { fg = "#7AD08D" }, -- fresh green, vibrant but soft
					sidebars = "dark",
					floats = "dark",
				},
				on_colors = function(colors)
					colors.bg = bg
					colors.bg_dark = bg_dark
					colors.bg_float = bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = bg_dark
					colors.bg_statusline = bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
			})

			vim.cmd([[colorscheme tokyonight]])
		end,
	},
}
