-- Highlight todo, notes, etc in comments
local Plugin = { "folke/todo-comments.nvim" }
Plugin.event = "VimEnter"
Plugin.dependencies = { "nvim-lua/plenary.nvim" }
Plugin.opts = { signs = false }
return Plugin
