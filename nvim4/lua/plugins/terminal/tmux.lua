-- File: ~/.config/nvim/lua/plugins/terminal/tmux.lua
--
-- This module configures seamless navigation between Neovim splits and Tmux panes.

return {
	"christoomey/vim-tmux-navigator",
	-- Load this plugin as soon as possible to ensure navigation is always available.
	lazy = false,
	-- We don't need a config block, but we will define the required keymaps
	-- and provide instructions for the necessary tmux configuration.
	config = function()
		-- The plugin works by mapping keys. It does this automatically.
		-- The keymaps we defined in `config/keymaps.lua` for <C-h/j/k/l>
		-- will be respected and enhanced by this plugin.

		-- No specific setup function is needed for this plugin.
		-- It's "plug and play" as long as your tmux.conf is set up.

		-- We can, however, define a few extra keymaps if we want.
		-- For example, to go to the previous tmux pane.
		-- vim.keymap.set("n", "<C-p>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true })
	end,
}

-- # ~/.tmux.conf
--
-- # Smart pane switching with awareness of Neovim splits.
-- # See: https://github.com/christoomey/vim-tmux-navigator
-- is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
--     | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
-- bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
-- bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
-- bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
-- bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
--
-- tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
-- if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
--     "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
-- if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
--     "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
--
-- bind-key -T copy-mode-vi 'C-h' select-pane -L
-- bind-key -T copy-mode-vi 'C-j' select-pane -D
-- bind-key -T copy-mode-vi 'C-k' select-pane -U
-- bind-key -T copy-mode-vi 'C-l' select-pane -R
-- bind-key -T copy-mode-vi 'C-\' select-pane -l
