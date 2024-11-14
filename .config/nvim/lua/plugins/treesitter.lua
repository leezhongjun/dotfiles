-- Builds AST to highlight, edit, and navigate code
local Plugin = { "nvim-treesitter/nvim-treesitter" }
Plugin.build = ":TSUpdate"
Plugin.opts = {
	ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
	auto_install = true,
	highlight = {
		enable = true,
		-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
		--  If you are experiencing weird indenting issues, add the language to
		--  the list of additional_vim_regex_highlighting and disabled languages for indent.
		additional_vim_regex_highlighting = { "ruby" },
	},
	indent = { enable = true, disable = { "ruby" } },
}
Plugin.config = function(_, opts)
	require("nvim-treesitter.install").prefer_git = true
	---@diagnostic disable-next-line: missing-fields
	require("nvim-treesitter.configs").setup(opts)

	--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
end
return Plugin
