vim.cmd [[
hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi VertSplit guibg=NONE ctermbg=NONE
]]

local set = vim.opt

set.guicursor = ""

set.nu = true
set.relativenumber = true

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.smartindent = true
set.wrap = true

set.swapfile = false
set.backup = false
set.undodir = ".vim/undodir"
set.undofile = true

set.hlsearch = false
set.incsearch = true

set.termguicolors = true
set.scrolloff = 8
set.isfname:append("@-@")
set.updatetime = 50
set.signcolumn = "yes"
