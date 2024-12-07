-- Autocompletion
local Plugin = { "hrsh7th/nvim-cmp" }
Plugin.event = "InsertEnter"
Plugin.dependencies = {
	-- Snippet Engine & its associated nvim-cmp source
	{
		"L3MON4D3/LuaSnip",
		build = (function()
			-- Build Step is needed for regex support in snippets.
			-- This step is not supported in many windows environments.
			-- Remove the below condition to re-enable on windows.
			if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
				return
			end
			return "make install_jsregexp"
		end)(),
	},
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
}
Plugin.opts = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	luasnip.config.setup({})

	cmp.setup({
		enabled = true,
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		completion = { completeopt = "menu,menuone,noinsert" },

		-- Read `:help ins-completion`
		mapping = cmp.mapping.preset.insert({
			-- Select the [n]ext item
			["<C-n>"] = cmp.mapping.select_next_item(),
			-- Select the [p]revious item
			["<C-p>"] = cmp.mapping.select_prev_item(),

			-- Accept the completion.
			--  This will auto-import if your LSP supports it.
			--  This will expand snippets if the LSP sent a snippet.
			["<C-e>"] = cmp.mapping.close(),
			["<Tab>"] = cmp.mapping.confirm({ select = true }),

			-- Reopen suggested completions
			["<C-Space>"] = cmp.mapping.complete({}),
		}),
		sources = {
			{ name = "copilot" },
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
		},
	})
end
return Plugin
