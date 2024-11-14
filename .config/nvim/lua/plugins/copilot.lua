-- Works with copilot-cmp
local Plugin = { "zbirenbaum/copilot.lua" }
Plugin.event = "InsertEnter"
Plugin.config = true
Plugin.opts = {
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
}
return Plugin
