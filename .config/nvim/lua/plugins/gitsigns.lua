-- Adds git related signs to the gutter, as well as utilities for managing changes
local Plugin = { "lewis6991/gitsigns.nvim" }
Plugin.opts = {
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
}
return Plugin
