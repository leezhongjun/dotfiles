-- [[ Keymaps ]]

-- Use <leader>p to paste over something without overwriting the buffer
vim.keymap.set("x", "<leader>p", '"_dP')

-- Clear ^M Windows endline characters when pasting
vim.keymap.set("n", ",m", function()
	vim.cmd(":%s/\r//g")
end)

-- Toggle inline hints
vim.keymap.set("n", "<leader>th", function()
	if vim.lsp.inlay_hint then
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(nil))
		print("Inlay Hints", vim.lsp.inlay_hint.is_enabled(nil) and "Enabled" or "Disabled")
	end
end, { desc = "[T]oggle Inlay [H]ints" })

-- Toggle terminal
-- Click C-g to toggle the terminal
-- Double click C-g to toggle off the terminal
vim.keymap.set("t", "<C-g>", "<C-\\><C-n>")

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
