local Plugin = { "kelly-lin/ranger.nvim" }
Plugin.config = function()
	require("ranger-nvim").setup({ replace_netrw = true })
	vim.api.nvim_set_keymap("n", "<leader>n", "", {
		noremap = true,
		callback = function()
			require("ranger-nvim").open(true)
		end,
		desc = "[N] Open ra[n]ger",
	})
end
return Plugin
