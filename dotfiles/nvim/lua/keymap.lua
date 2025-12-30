-- file
vim.keymap.set("n", "<leader>ff", ":Ex<CR>")

-- toggles
vim.keymap.set("n", "<leader>tt", ":Twilight<CR>")

-- buffers
vim.keymap.set("n", "<leader>bp", ":bprev<CR>")
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bc", ":bdelete<CR>")

-- windows

-- splits
vim.keymap.set("n", "<leader>ws", ":split<CR>")
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>")

-- closing
vim.keymap.set("n", "<leader>wc", ":close<CR>")
vim.keymap.set("n", "<leader>wn", "<C-w>w")
vim.keymap.set("n", "<leader>ww", "<C-w>w")
vim.keymap.set("n", "<leader>wp", "<C-w>W")

-- diagnositcs
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })


