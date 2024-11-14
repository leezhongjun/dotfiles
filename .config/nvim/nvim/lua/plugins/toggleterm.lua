local Plugin = { "akinsho/toggleterm.nvim" }
Plugin.keys = { { "<C-g>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" } } }
Plugin.opts = {
	open_terminal = "<C-g>",
	direction = "horizontal",
	shade_terminals = true,
}
return Plugin
