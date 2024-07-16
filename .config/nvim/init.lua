--  kickstart.nvim

-- Inlay hints
-- Off by default
-- if _G.ih == nil then
-- 	_G.ih = true
-- end

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- [[ Set Opts ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

-- [[ Basic Keymaps ]]
-- Use <leader>p to paste over something without overwriting the buffer
vim.keymap.set("x", "<leader>p", '"_dP')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- [[ Basic Autocommands ]]
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
	require("lazy").setup({
		"tpope/vim-sleuth",

		-- "gc" to comment visual regions/lines
		{ "numToStr/Comment.nvim", opts = {} },

		-- autopairs
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
			opts = {},
		},

		{ -- Collection of various small independent plugins/modules
			"echasnovski/mini.nvim",
			config = function()
				-- Better Around/Inside textobjects
				--
				-- Examples:
				--  - va)  - [V]isually select [A]round [)]paren
				--  - yinq - [Y]ank [I]nside [N]ext [']quote
				--  - ci'  - [C]hange [I]nside [']quote
				require("mini.ai").setup({ n_lines = 500 })

				-- Add/delete/replace surroundings (brackets, quotes, etc.)
				--
				-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
				-- - sd'   - [S]urround [D]elete [']quotes
				-- - sr)'  - [S]urround [R]eplace [)] [']
				require("mini.surround").setup()

				-- local statusline = require("mini.statusline")
				-- -- set use_icons to true if you have a Nerd Font
				-- statusline.setup({ use_icons = vim.g.have_nerd_font })
				--
				-- -- You can configure sections in the statusline by overriding their
				-- -- default behavior. For example, here we set the section for
				-- -- cursor location to LINE:COLUMN
				-- ---@diagnostic disable-next-line: duplicate-set-field
				-- statusline.section_location = function()
				-- 	return "%2l:%-2v"
				-- end
			end,
		},

		-- {
		-- 	"rmagatti/auto-session",
		-- 	opts = {
		-- 		log_level = "error",
		-- 		auto_session_enable_last_session = true,
		-- 		auto_session_enabled = true,
		-- 		auto_session_create_enabled = true,
		-- 	},
		-- },
	})
else
	-- [[ Configure and install plugins ]]
	require("lazy").setup({
		"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

		-- "gc" to comment visual regions/lines
		{ "numToStr/Comment.nvim", opts = {} },

		-- copilot
		{
			"zbirenbaum/copilot.lua",
			event = "InsertEnter",
			config = true,
			-- disabled here because it is used later in copilot-cmp
			opts = {
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = false,
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
			},
		},

		{
			"zbirenbaum/copilot-cmp",
			config = true,
			opts = {},
		},

		-- autopairs
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
			opts = {},
		},

		{ -- Adds git related signs to the gutter, as well as utilities for managing changes
			"lewis6991/gitsigns.nvim",
			opts = {
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			},
		},

		{ -- Useful plugin to show you pending keybinds.
			"folke/which-key.nvim",
			event = "VimEnter", -- Sets the loading event to 'VimEnter'
			config = function() -- This is the function that runs, AFTER loading
				require("which-key").setup()

				-- Document existing key chains
				require("which-key").register({
					["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
					["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
					["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
					["<leader>a"] = { name = "[S]earch", _ = "which_key_ignore" },
					["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
					["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
					["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
				})
				-- visual mode
				require("which-key").register({
					["<leader>h"] = { "Git [H]unk" },
				}, { mode = "v" })
			end,
		},

		{ -- Fuzzy Finder (files, lsp, etc)
			"nvim-telescope/telescope.nvim",
			event = "VimEnter",
			branch = "0.1.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{ -- If encountering errors, see telescope-fzf-native README for installation instructions
					"nvim-telescope/telescope-fzf-native.nvim",

					build = "make",

					cond = function()
						return vim.fn.executable("make") == 1
					end,
				},
				{
					"nvim-telescope/telescope-ui-select.nvim",
				},
			},
			config = function()
				-- Telescope is a fuzzy finder that comes with a lot of different things that
				-- it can fuzzy find! It's more than just a "file finder", it can search
				-- many different aspects of Neovim, your workspace, LSP, and more!
				--
				-- The easiest way to use Telescope, is to start by doing something like:
				--  :Telescope help_tags
				--
				-- After running this command, a window will open up and you're able to
				-- type in the prompt window. You'll see a list of `help_tags` options and
				-- a corresponding preview of the help.
				--
				-- Two important keymaps to use while in Telescope are:
				--  - Insert mode: <c-/>
				--  - Normal mode: ?
				--
				-- This opens a window that shows you all of the keymaps for the current
				-- Telescope picker. This is really useful to discover what Telescope can
				-- do as well as how to actually do it!

				-- [[ Configure Telescope ]]
				-- See `:help telescope` and `:help telescope.setup()`
				require("telescope").setup({
					-- You can put your default mappings / updates / etc. in here
					--  All the info you're looking for is in `:help telescope.setup()`
					--
					-- defaults = {
					--   mappings = {
					--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
					--   },
					-- },
					-- pickers = {}
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown(),
						},
					},
				})

				-- Enable Telescope extensions if they are installed
				pcall(require("telescope").load_extension, "fzf")
				pcall(require("telescope").load_extension, "ui-select")

				-- See `:help telescope.builtin`
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
				vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
				vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
				vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
				vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
				vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
				vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
				vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
				vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
				vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

				-- Slightly advanced example of overriding default behavior and theme
				vim.keymap.set("n", "<leader>/", function()
					-- You can pass additional configuration to Telescope to change the theme, layout, etc.
					builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end, { desc = "[/] Fuzzily search in current buffer" })

				-- It's also possible to pass additional configuration options.
				--  See `:help telescope.builtin.live_grep()` for information about particular keys
				vim.keymap.set("n", "<leader>s/", function()
					builtin.live_grep({
						grep_open_files = true,
						prompt_title = "Live Grep in Open Files",
					})
				end, { desc = "[S]earch [/] in Open Files" })

				-- Shortcut for searching your Neovim configuration files
				vim.keymap.set("n", "<leader>sn", function()
					builtin.find_files({ cwd = vim.fn.stdpath("config") })
				end, { desc = "[S]earch [N]eovim files" })
			end,
		},

		{ -- LSP Configuration & Plugins
			"neovim/nvim-lspconfig",
			dependencies = {
				{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",

				-- Useful status updates for LSP.
				{ "j-hui/fidget.nvim", opts = {} },

				-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
				-- used for completion, annotations and signatures of Neovim apis
				{ "folke/neodev.nvim", opts = {} },
			},
			config = function()
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
					callback = function(event)
						local map = function(keys, func, desc)
							vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end

						-- Jump to the definition of the word under your cursor.
						--  This is where a variable was first declared, or where a function is defined, etc.
						--  To jump back, press <C-t>.
						map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

						-- Find references for the word under your cursor.
						map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

						-- Jump to the implementation of the word under your cursor.
						--  Useful when your language has ways of declaring types without an actual implementation.
						map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

						-- Jump to the type of the word under your cursor.
						--  Useful when you're not sure what type a variable is and you want to see
						--  the definition of its *type*, not where it was *defined*.
						map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

						-- Fuzzy find all the symbols in your current document.
						--  Symbols are things like variables, functions, types, etc.
						map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

						-- Fuzzy find all the symbols in your current workspace.
						--  Similar to document symbols, except searches over your entire project.
						map(
							"<leader>ws",
							require("telescope.builtin").lsp_dynamic_workspace_symbols,
							"[W]orkspace [S]ymbols"
						)

						-- Rename the variable under your cursor.
						--  Most Language Servers support renaming across files, etc.
						map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

						-- Execute a code action, usually your cursor needs to be on top of an error
						-- or a suggestion from your LSP for this to activate.
						map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

						-- Opens a popup that displays documentation about the word under your cursor
						--  See `:help K` for why this keymap.
						map("K", vim.lsp.buf.hover, "Hover Documentation")

						-- WARN: This is not Goto Definition, this is Goto Declaration.
						--  For example, in C this would take you to the header.
						map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

						-- When you move your cursor, the highlights will be cleared (the second autocommand).
						local client = vim.lsp.get_client_by_id(event.data.client_id)
						if client and client.server_capabilities.documentHighlightProvider then
							local highlight_augroup =
								vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.document_highlight,
							})

							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.clear_references,
							})

							vim.api.nvim_create_autocmd("LspDetach", {
								group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
								callback = function(event2)
									vim.lsp.buf.clear_references()
									vim.api.nvim_clear_autocmds({
										group = "kickstart-lsp-highlight",
										buffer = event2.buf,
									})
								end,
							})
						end

						-- The following autocommand is used to enable inlay hints in your
						-- code, if the language server you are using supports them
						--
						-- This may be unwanted, since they displace some of your code
						map("<leader>th", function()
							_G.ih = not _G.ih
							print("Inlay hints", _G.ih and "Enabled" or "Disabled")
						end, "[T]oggle Inlay [H]ints")
					end,
				})

				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities =
					vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
				local clangdCapabilities = capabilities
				clangdCapabilities.offsetEncoding = "utf-8"

				--  Add any additional override configuration in the following tables. Available keys are:
				--  - cmd (table): Override the default command used to start the server
				--  - filetypes (table): Override the default list of associated filetypes for the server
				--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
				--  - settings (table): Override the default settings passed when initializing the server.
				local servers = {
					clangd = { capabilities = clangdCapabilities },
					gopls = { capabilities = capabilities },
					pyright = { capabilities = capabilities },
					rust_analyzer = {},
					-- tsserver = {},
					-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs

					lua_ls = {
						capabilities = capabilities,
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
								-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
								-- diagnostics = { disable = { 'missing-fields' } },
							},
						},
					},
				}

				require("mason").setup()

				-- Disabled becuase Android auto-install does not work
				-- local ensure_installed = vim.tbl_keys(servers or {})
				-- vim.list_extend(ensure_installed, {
				-- 	"stylua", -- Used to format Lua code
				-- })
				-- require("mason-tool-installer").setup({
				-- 	ensure_installed = ensure_installed,
				-- })

				require("mason-lspconfig").setup({
					-- Disabled becuase Android auto-install does not work
					automatic_installation = false,
				})
				local lconf = require("lspconfig")
				for k, v in pairs(servers) do
					lconf[k].setup(v)
				end
			end,
		},

		{ -- Autoformat
			"stevearc/conform.nvim",
			lazy = false,
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true, lsp_fallback = true })
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
			opts = {
				notify_on_error = false,
				format_on_save = function(bufnr)
					-- Disable "format_on_save lsp_fallback" for languages that don't
					-- have a well standardized coding style. You can add additional
					-- languages here or re-enable it for the disabled ones.
					local disable_filetypes = { c = true, cpp = true }
					return {
						timeout_ms = 500,
						lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
					}
				end,
				formatters_by_ft = {
					lua = { "stylua" },
					python = { { "autopep8", "pyright" } },
					rust = { "rustfmt" },
					go = { "gofmt" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					markdown = { "markdown-toc" },
					json = { "jq" },
					-- javascript = { { "prettierd", "prettier" } },
				},
				inlay_hints = {
					enabled = function()
						return _G.ih
					end,
				},
			},
		},

		{ -- Autocompletion
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
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
			},
			config = function()
				local cmp = require("cmp")
				local luasnip = require("luasnip")
				luasnip.config.setup({})

				cmp.setup({
					enabled = function()
						return _G.ih
					end,
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

						-- Scroll the documentation window [b]ack / [f]orward
						-- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
						-- ["<C-f>"] = cmp.mapping.scroll_docs(4),

						-- Accept ([y]es) the completion.
						--  This will auto-import if your LSP supports it.
						--  This will expand snippets if the LSP sent a snippet.
						["<C-y>"] = cmp.mapping.confirm({ select = true }),
						["<Tab>"] = cmp.mapping.confirm({ select = true }),
						["<C-e>"] = cmp.mapping.close(),

						-- ["<CR>"] = cmp.mapping.confirm({ select = true }),
						-- ["<Tab>"] = cmp.mapping.select_next_item(),
						-- ["<S-Tab>"] = cmp.mapping.select_prev_item(),

						-- Manually trigger a completion from nvim-cmp.
						--  Generally you don't need this, because nvim-cmp will display
						--  completions whenever it has completion options available.
						["<C-Space>"] = cmp.mapping.complete({}),

						-- Think of <c-l> as moving to the right of your snippet expansion.
						--  So if you have a snippet that's like:
						--  function $name($args)
						--    $body
						--  end
						--
						-- <c-l> will move you to the right of each of the expansion locations.
						-- <c-h> is similar, except moving you backwards.
						-- ["<C-l>"] = cmp.mapping(function()
						-- 	if luasnip.expand_or_locally_jumpable() then
						-- 		luasnip.expand_or_jump()
						-- 	end
						-- end, { "i", "s" }),
						-- ["<C-h>"] = cmp.mapping(function()
						-- 	if luasnip.locally_jumpable(-1) then
						-- 		luasnip.jump(-1)
						-- 	end
						-- end, { "i", "s" }),
						--
					}),
					sources = {
						{ name = "copilot" },
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "path" },
					},
				})
			end,
		},

		{ -- You can easily change to a different colorscheme.
			-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
			"folke/tokyonight.nvim",
			priority = 1000, -- Make sure to load this before all the other start plugins.
			init = function()
				vim.cmd.colorscheme("tokyonight-night")
				-- You can configure highlights by doing something like:
				vim.cmd.hi("Comment gui=none")
			end,
		},

		-- Highlight todo, notes, etc in comments
		{
			"folke/todo-comments.nvim",
			event = "VimEnter",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = { signs = false },
		},

		{ -- Collection of various small independent plugins/modules
			"echasnovski/mini.nvim",
			config = function()
				-- Better Around/Inside textobjects
				--
				-- Examples:
				--  - va)  - [V]isually select [A]round [)]paren
				--  - yinq - [Y]ank [I]nside [N]ext [']quote
				--  - ci'  - [C]hange [I]nside [']quote
				require("mini.ai").setup({ n_lines = 500 })

				-- Add/delete/replace surroundings (brackets, quotes, etc.)
				--
				-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
				-- - sd'   - [S]urround [D]elete [']quotes
				-- - sr)'  - [S]urround [R]eplace [)] [']
				require("mini.surround").setup()

				local statusline = require("mini.statusline")
				-- set use_icons to true if you have a Nerd Font
				statusline.setup({ use_icons = vim.g.have_nerd_font })

				-- You can configure sections in the statusline by overriding their
				-- default behavior. For example, here we set the section for
				-- cursor location to LINE:COLUMN
				---@diagnostic disable-next-line: duplicate-set-field
				statusline.section_location = function()
					return "%2l:%-2v"
				end
			end,
		},

		{ -- Highlight, edit, and navigate code
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			opts = {
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
			},
			config = function(_, opts)
				require("nvim-treesitter.install").prefer_git = true
				---@diagnostic disable-next-line: missing-fields
				require("nvim-treesitter.configs").setup(opts)

				--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
				--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
				--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
			end,
		},

		{
			"kelly-lin/ranger.nvim",
			config = function()
				require("ranger-nvim").setup({ replace_netrw = true })
				vim.api.nvim_set_keymap("n", "<leader>n", "", {
					noremap = true,
					callback = function()
						require("ranger-nvim").open(true)
					end,
				})
			end,
		},

		{
			"rmagatti/auto-session",
			opts = {
				log_level = "error",
				auto_session_enable_last_session = true,
				auto_session_enabled = true,
				auto_session_create_enabled = true,
			},
		},

		{
			"ellisonleao/glow.nvim",
			config = true,
			opts = {
				style = "dark",
			},
			cmd = "Glow",
		},

		{
			"gaoDean/autolist.nvim",
			ft = {
				"markdown",
				"text",
				"tex",
				"plaintex",
				"norg",
			},
			config = function()
				require("autolist").setup()

				vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
				vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
				-- vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
				-- vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
				vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
				vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
				-- vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
				-- vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")

				-- cycle list types with dot-repeat
				vim.keymap.set("n", "<leader>cn", require("autolist").cycle_next_dr, { expr = true })
				vim.keymap.set("n", "<leader>cp", require("autolist").cycle_prev_dr, { expr = true })

				-- if you don't want dot-repeat
				-- vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>")
				-- vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>")

				-- functions to recalculate list on edit
				vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
				vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
				vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
				vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
			end,
			opts = {},
		},

		-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
		--    This is the easiest way to modularize your config.
		--
		--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
		--    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
		-- { import = 'custom.plugins' },
	})
end
-- for -- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
