-- Works with copilot-cmp
local Plugin = { "zbirenbaum/copilot.lua" }
Plugin.event = "VeryLazy"
Plugin.config = function()
	require("copilot").setup({
		panel = {
			enabled = true,
		},
		suggestion = {
			enabled = true,
		},
		filetypes = {
			yaml = true,
			markdown = true,
			help = true,
			gitcommit = true,
			gitrebase = true,
			hgcommit = true,
			svn = true,
			cvs = true,
			["."] = true,
		},
	})
	if not vim.g.COPILOT_ENABLED then
		vim.cmd("Copilot disable")
	end
end
return Plugin
