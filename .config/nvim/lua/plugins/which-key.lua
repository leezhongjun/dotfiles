-- Show pending keybinds
local Plugin = { "folke/which-key.nvim" }
Plugin.event = "VimEnter"
Plugin.config = function()
	require("which-key").setup()
	require("which-key").add({
		{ "<leader>a", group = "[S]earch" },
		{ "<leader>a_", hidden = true },
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>c_", hidden = true },
		{ "<leader>d", group = "[D]ocument" },
		{ "<leader>d_", hidden = true },
		{ "<leader>h", group = "Git [H]unk" },
		{ "<leader>h_", hidden = true },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>r_", hidden = true },
		{ "<leader>t", group = "Copilo[t]" },
		{ "<leader>t_", hidden = true },
		{ "<leader>w", group = "[W]orkspace" },
		{ "<leader>w_", hidden = true },
	})
	require("which-key").add({
		{ "<leader>h", desc = "Git [H]unk", mode = "v" },
	})
end
return Plugin
