local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, {
    noremap = true,
    silent = true,
    desc = desc
  })
end

-- top level bindings
map("n", "<leader><tab>", ":Ex<cr>", "File explorer")
map("n", "<leader>/", ":noh<cr>", "Clear search hiighlights")

-- window movement
map("n", "<leader>ww", "<C-w>w", "Next window")
map("n", "<leader>wp", "<C-w>W", "Previous window")
map("n", "<leader>wh", "<C-w>h", "Window left")
map("n", "<leader>wj", "<C-w>j", "Window down")
map("n", "<leader>wk", "<C-w>k", "Window up")
map("n", "<leader>wl", "<C-w>l", "Window right")
map("n", "<leader>wc", "<C-w>c", "Close window")

-- splits
map("n", "<leader>ws", "<C-w>s", "Split horizontal")
map("n", "<leader>wv", "<C-w>v", "Split vertical")

-- buffer movement
map("n", "<leader>bn", ":bnext<CR>", "Next buffer")
map("n", "<leader>bp", ":bprevious<CR>", "Previous buffer")
map("n", "<leader>bd", ":bdelete<CR>", "Delete buffer")

-- file stuff
map("n", "<leader>ff", ":Telescope find_files<CR>", "Find file")
map("n", "<leader>fg", ":Telescope live_grep<CR>", "Find in files")
map("n", "<leader>fb", ":Telescope buffers<CR>", "Find buffer")
map("n", "<leader>fh", ":Telescope help_tags<CR>", "Find help")
map("n", "<leader>fr", ":Telescope oldfiles<CR>", "Recent files")

-- git bindings
map("n", "<leader>gs", "<cmd>Neogit<cr>", "Neogit Status")
map("n", "<leader>gr", "<cmd>Neogit rebase<cr>", "Neogit Rebase")
