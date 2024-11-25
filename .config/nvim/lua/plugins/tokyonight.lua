-- Color scheme
local Plugin = { "folke/tokyonight.nvim" }
Plugin.priority = 1000 -- load this before all other plugins
Plugin.init = function()
	vim.cmd.colorscheme("tokyonight-night")
	-- You can configure highlights by doing something like:
	vim.cmd.hi("Comment gui=none")
end
return Plugin
